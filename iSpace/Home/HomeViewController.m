//
//  HomeViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HomeViewController.h"
#import "SetColckViewController.h"

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
    //更新设备
     [self updateDevices];
    
    self.bobyView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight-100);
    //设置闹钟的alpha
    NSArray *clockArr = @[_clock1 , _clock2 , _clock3 , _clock4 , _clockLabel1 , _clockLabel2 , _clockLabel3 , _clockLabel4];
    for (UIView *v  in clockArr) {
        v.alpha = 0.3 ;
    }
    //添加设备视图
    [self addiSpace];
        
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDatetime:) name:@"123" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)addiSpace
{
    _otheriSpace.top = _endView.bottom ;
    [self.bobyView addSubview:_otheriSpace];
}
#pragma mark-------点击确定按钮
- (void)getDatetime:(NSNotification*)note
{
    NSDictionary *dataDict = [note object];
    NSArray *keyArr = [dataDict allKeys];
    NSDate *dictKey = keyArr[0];
    NSDate *date = dataDict[dictKey];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm:aa"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    NSInteger clockTag = [keyArr[0] integerValue];
    
    switch (clockTag) {
        case 1:
            _clock1.time = date ;
            [_clock1 setNeedsDisplay];
            _clockLabel1.text = timeStr ;
            _clockLabel1.alpha = 1.0 ;
            _clock1.alpha = 1.0 ;
            break;
        case 2:
            _clock2.time = date ;
            [_clock2 setNeedsDisplay];
            _clockLabel2.text = timeStr ;
            _clockLabel2.alpha = 1.0 ;
            _clock2.alpha = 1.0 ;
            break;
        case 3:
            _clock3.time = date ;
            [_clock3 setNeedsDisplay];
            _clockLabel3.text = timeStr ;
            _clockLabel3.alpha = 1.0 ;
            _clock3.alpha = 1.0 ;
            break;
        case 4:
            _clock4.time = date ;
            [_clock4 setNeedsDisplay];
            _clockLabel4.text = timeStr ;
            _clockLabel4.alpha = 1.0 ;
            _clock4.alpha = 1.0 ;
            break;

        default:
            break;
    }


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
}
#pragma mark-----登录成功在后台更新设备
-(void)updateDevices
{
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2051" andNeedUserId:USER_ID AndNeedBobyArrKey:@[ @"dev_type"] andNeedBobyArrValue:@[ @"0" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"updateing" andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@" , result);
        NSDictionary *returnDict = result[@"message_body"];
        NSString *returnInfo = returnDict[@"error"];
        int returnInt = [returnInfo intValue];
        
        NSDictionary *dev_list =returnDict [@"dev_list"];
        NSArray *list = dev_list[@"list"];
        NSLog(@"%@ , %@" , dev_list , list);
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
    }
    
}

@end
