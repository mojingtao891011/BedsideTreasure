//
//  HomeViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HomeViewController.h"
#import "SetColckViewController.h"
#import "DevicesInfoModel.h"
#import "AlarmInfoModel.h"
#import "OtherDevicesTableViewCell.h"

@interface HomeViewController ()
{
    int count ;
}
@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"主页" ;
        [self.titleLabel sizeToFit];
       
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //更新设备
     [self updateDevices];
    
    self.bobyView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-100);
    
    _clockArr = @[_clock1 , _clock2 , _clock3 , _clock4];
    _clockLabelArr = @[_clockLabel1 , _clockLabel2 , _clockLabel3 , _clockLabel4];
    
    _otherDevicesView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 200);
    [self.view addSubview:_otherDevicesView];
    [_otherDevicesTableView registerNib:[UINib nibWithNibName:@"OtherDevicesTableViewCell" bundle:nil] forCellReuseIdentifier:@"OtherDevicesTableViewCell"];
    [self setExtraCellLineHidden:_otherDevicesTableView];
    _devicesTotalArr = [[NSMutableArray alloc]initWithCapacity:4];
    count = 100 ;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getIndexs:) name:@"POSTINDEXS" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeDevices:) name:@"addDevicesButtonAction" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark--------NSNotificationCenter
- (void)getIndexs:(NSNotification*)note
{
    NSString *index = [note object];
    count = index.intValue ;
    [_otherDevicesTableView reloadData];
}
- (void)changeDevices:(NSNotification*)note
{
    _addButton.selected = YES ;
    [self addOtheriSpace:_addButton];
}
#pragma mark-------点击闹钟进入闹钟设置界面
- (IBAction)clickClock:(id)sender {
    
    SetColckViewController *setClockViewCtl = [[SetColckViewController alloc]init];
    Clock *clock = (Clock*)sender ;
    setClockViewCtl.clockButtonTag = clock.tag ;
    [self.navigationController pushViewController:setClockViewCtl animated:YES];
}
#pragma mark-------点击添加设备按钮
- (IBAction)addOtheriSpace:(id)sender {
    
    _addButton.selected = !_addButton.selected ;
    if (_addButton.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            _otherDevicesView.top = ScreenHeight - _otherDevicesView.height - 100 ;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _otherDevicesView.top = ScreenHeight ;
        }];

    }
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _devicesTotalArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OtherDevicesTableViewCell *otherDevicesCell = [tableView dequeueReusableCellWithIdentifier:@"OtherDevicesTableViewCell"];
    otherDevicesCell.redioButton.tag = 10 + indexPath.row ;
    if (indexPath.row == count) {
        otherDevicesCell.redioButton.selected = YES ;
        otherDevicesCell.cancelButton.hidden = NO ;
        otherDevicesCell.enterButton.hidden = NO ;
    }
    else{
        otherDevicesCell.redioButton.selected = NO ;
        otherDevicesCell.cancelButton.hidden = YES ;
        otherDevicesCell.enterButton.hidden = YES ;
    }
    if (indexPath.row == 0) {
        otherDevicesCell.devicesName.text = @"切换到其他设备";
        otherDevicesCell.redioButton.hidden = YES ;
        return otherDevicesCell ;
    }
    DevicesInfoModel *devicesModel = _devicesTotalArr[indexPath.row];
    otherDevicesCell.devicesName.text = devicesModel.dev_name ;
    return otherDevicesCell ;
}
#pragma mark-----UITableViewDelegate
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark-----登录成功在后台更新设备
-(void)updateDevices
{
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2051" andNeedUserId:USER_ID AndNeedBobyArrKey:@[ @"dev_type"] andNeedBobyArrValue:@[ @"0" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"updateing" andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@" ,result);
        NSDictionary *returnDict = result[@"message_body"];
        
        NSString *returnInfo = returnDict[@"error"];
        int returnInt = [returnInfo intValue];
        
        //如果等于0说明有绑定设备
        if (returnInt == 0) {
             NSDictionary *dev_list = returnDict[@"dev_list"];
            NSArray *listArr = dev_list[@"list"] ;
    
            for (NSDictionary *deviceDict in listArr) {
                
                //  把闹钟信息装进模型里
                DevicesInfoModel *devicesInfoModel = [[DevicesInfoModel alloc]initWithDataDic:deviceDict];
                
                //把绑定设备个数一一装进数组里
                [_devicesTotalArr addObject:devicesInfoModel];
                
            }
        }
        DevicesInfoModel *model = _devicesTotalArr[0];
        NSLog(@"%@" , model.alermInfo);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateDevicesComplete:returnInt];
        });
    }];
}
#pragma mark-----后台更新设备完成后反馈回来的数据
- (void)updateDevicesComplete:(int)infoInt
{
    if (infoInt != 0) {
        UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        maskView.alpha = 0.3 ;
        maskView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:maskView];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"该页面不可操作，亲～你可能还未绑定设备哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{
        [self updateAlarmInfo];
    }
    [_otherDevicesTableView reloadData];
    
}
#pragma mark-----后台更新设备获取的数据显示出来
- (void)updateAlarmInfo
{
    DevicesInfoModel *devicesInfoMdel = _devicesTotalArr[0];
    NSMutableArray *alarmInfoArr = devicesInfoMdel.alermInfoArr ;
    for ( int i = 0 ; i < alarmInfoArr.count ; i++) {
        AlarmInfoModel *alarmInfoModel = alarmInfoArr[i];
        NSString *timeStr = [NSString stringWithFormat:@"%@:%@",alarmInfoModel.hour , alarmInfoModel.minute];
        //把NSString转化为NSDate
        NSDate* date = [self dateFromFomate:timeStr formate:@"HH:mm"];
        
        Clock *clock = _clockArr[i];
        clock.time = date ;
        [clock setNeedsDisplay];
        
        UILabel *timerLabel = _clockLabelArr[i];
        timerLabel.text = timeStr ;
    }
 
}
#pragma mark------把NSString转化为NSDate
- (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
    [formatter setLocale: local];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}
@end
