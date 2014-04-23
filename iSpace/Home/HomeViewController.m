//
//  HomeViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HomeViewController.h"
#import "DevicesInfoModel.h"
#import "DevicesNameCell.h"
#import "WeatherCell.h"
#import "AlarmCell.h"
#import "OtherDevicesCell.h"

@interface HomeViewController ()

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
    _devicesTotalArr = [[NSMutableArray alloc]initWithCapacity:4];
    _index = 0 ;
     [self updateDevices];
    [self registerNibCell];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refresh"];
    [refreshControl addTarget:self action:@selector(refreshAction) forControlEvents: UIControlEventValueChanged ];
    
   
}
- (void)refreshAction
{
    NSLog(@"sdd");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registerNibCell
{
    [_homeTableView registerNib:[UINib nibWithNibName:@"DevicesNameCell" bundle:nil] forCellReuseIdentifier:@"DevicesNameCell"];
    [_homeTableView registerNib:[UINib nibWithNibName:@"WeatherCell" bundle:nil] forCellReuseIdentifier:@"WeatherCell"];
    [_homeTableView registerNib:[UINib nibWithNibName:@"AlarmCell" bundle:nil] forCellReuseIdentifier:@"AlarmCell"];
    [_homeTableView registerNib:[UINib nibWithNibName:@"OtherDevicesCell" bundle:nil] forCellReuseIdentifier:@"OtherDevicesCell"];
    
    
}
#pragma mark------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DevicesNameCell *nameCell = [tableView dequeueReusableCellWithIdentifier:@"DevicesNameCell"];
    WeatherCell *weatherCell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell"];
    AlarmCell  *alarmCell = [tableView dequeueReusableCellWithIdentifier:@"AlarmCell"];
    OtherDevicesCell  *otherDevicesCell = [tableView dequeueReusableCellWithIdentifier:@"OtherDevicesCell"];
    NSArray *cellArr = @[nameCell , weatherCell , alarmCell , otherDevicesCell];
    
    if (_devicesTotalArr.count != 0) {
        DevicesInfoModel *devicesModel = _devicesTotalArr[_index];
        nameCell.devicesNameLabel.text = devicesModel.dev_name ;
        alarmCell.alarmInfoArr = [devicesModel.alermInfoArr mutableCopy];
        alarmCell.pushViewCtl = self ;
        //保存设备索引
        [[NSUserDefaults standardUserDefaults] setObject:devicesModel.dev_sn forKey:@"dev_sn"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        
    }
    
    return cellArr[indexPath.row] ;
}
#pragma mark------UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *heightArr = @[@"80" , @"120" , @"120" , @"44"];
    CGFloat height = [heightArr[indexPath.row] floatValue];
    return height ;
}
#pragma mark-----登录成功在后台更新设备
-(void)updateDevices
{
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2051" andNeedUserId:USER_ID AndNeedBobyArrKey:@[ @"dev_type"] andNeedBobyArrValue:@[ @"0" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"updateing" andViewCtl:self completeBlock:^(id result){
        
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
         [_homeTableView reloadData];
    }
   
}

@end
