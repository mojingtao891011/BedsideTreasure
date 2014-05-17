//
//  HomecViewController.m
//  Home
//
//  Created by bear on 14-5-11.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HomeViewController.h"
#import "DevicesInfoModel.h"
#import "SetColckViewController.h"
#import "WeatherInfo.h"

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
    _cellArr = @[_iSpaceNameCell , _iSpaceWeathCell , _iSpaceClockCell , _iSpaceOtherCell];
    _devicesTotalArr = [[NSMutableArray alloc]initWithCapacity:4];
    _clockArr = @[_clock1 , _clock2 , _clock3 , _clock4];
    _clockLabelArr = @[_label1 , _label2 , _label3 , _label4];
   
    [self updateDevices];


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _cellArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *homeCell = _cellArr[indexPath.row];
    return homeCell ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *heightRowArr = @[@"100" , @"120" , @"160" , @"60"];
    return [heightRowArr[indexPath.row] floatValue];
}
#pragma mark-----更新闹钟信息
- (void)updateAlertInfo
{
    if (_devicesTotalArr.count != 0) {
        DevicesInfoModel *devicesModel = _devicesTotalArr[0];
        _devicesCity = devicesModel.dev_city ;
        //保存设备索引
        [[NSUserDefaults standardUserDefaults] setObject:devicesModel.dev_sn forKey:@"dev_sn"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        _alarmInfoArr = [devicesModel.alermInfoArr mutableCopy];
        int lenght = 0 ;
        if (_alarmInfoArr.count > 4) {
            lenght = 4 ;
        }
        else{
            lenght = _alarmInfoArr.count ;
        }
        for (int i = 0 ; i < lenght ; i++) {
            AlarmInfoModel *alarmModel = _alarmInfoArr[i] ;
            if (alarmModel.hour.length ==0  || alarmModel.minute.length == 0) {
                return ;
            }
            NSString *hour = alarmModel.hour ;
            NSString *minute = alarmModel.minute ;
            if ([alarmModel.hour intValue] <= 9) {
                hour = [NSString stringWithFormat:@"0%@" , alarmModel.hour];
            }
            if ([alarmModel.minute intValue] <= 9) {
                minute = [NSString stringWithFormat:@"0%@" , alarmModel.minute];
            }
            NSString *timeStr = [NSString stringWithFormat:@"%@:%@",hour , minute];
            //把NSString转化为NSDate
            NSDate* date = [self dateFromFomate:timeStr formate:@"HH:mm"];
            
            AlarmClock *clock = _clockArr[i];
            clock.time = date ;
            [clock setNeedsDisplay];
            
            UILabel *timeLabel = _clockLabelArr[i] ;
            
            timeLabel.text = timeStr;
            
        }
    }
    [self getWeatherInfo];

}
#pragma mark------把NSString转化为NSDate
- (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
    [formatter setLocale: local];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

#pragma mark-----点击闹钟进入闹钟设置界面
- (IBAction)clickAlarmClockAction:(UIButton *)sender {
    NSLog(@"%d" , sender.tag);
    SetColckViewController *setClockViewCtl = [[SetColckViewController alloc]init];
    setClockViewCtl.clockButtonTag = sender.tag ;
    [self.navigationController pushViewController:setClockViewCtl animated:YES];
}
#pragma mark-----切换设备动作
- (IBAction)changeDevicesAction:(UIButton *)sender
{
    sender.selected = !sender.selected ;
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"可切换的设备" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (int i= 1 ; i < _devicesTotalArr.count ; i++) {
        DevicesInfoModel *model = _devicesTotalArr[i];
        [actionSheet addButtonWithTitle:model.dev_name];
    }
    [actionSheet showInView:self.view];

}

#pragma mark-----登录成功在后台更新设备
-(void)updateDevices
{
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2051" andNeedUserId:USER_ID AndNeedBobyArrKey:@[ @"dev_type"] andNeedBobyArrValue:@[ @"-1" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
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
#pragma mark-----获取天气信息
- (void)getWeatherInfo
{
        
    NSString *devicesCity = [[NSString alloc]initWithData:[GTMBase64 encodeData:[@"深圳" dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NetDataService needCommand:@"2076" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"req_id" , @"city"] andNeedBobyArrValue:@[@"-1" , devicesCity]];
    
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
        NSDictionary *returnDict = result[@"message_body"];
        int errorInt = [returnDict[@"error"] intValue];
        WeatherInfo *weatherInfoModel = nil ;
        if (errorInt == 0) {
            weatherInfoModel = [[WeatherInfo alloc]initWithDataDic:returnDict] ;
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (errorInt == 0) {
                _devicesCityLabel.text = [[NSString alloc]initWithData:[GTMBase64 decodeData:[_devicesCity dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding] ,[_devicesCityLabel sizeToFit];
                _TemperatureLabel.text = weatherInfoModel.tempreature ,[_TemperatureLabel sizeToFit];
                _weatherStatus.text = weatherInfoModel.weather , [_weatherStatus sizeToFit];
                _dateLabel.text = weatherInfoModel.datetime , [_dateLabel sizeToFit];
                _weekLabel.text = weatherInfoModel.title , [_weekLabel sizeToFit] ;
                
            }
        });
    }];
}
#pragma mark-----后台更新设备完成后反馈回来的数据
- (void)updateDevicesComplete:(int)infoInt
{
    if (_devicesTotalArr.count== 0) {
        UIView *maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        maskView.alpha = 0.3 ;
        maskView.backgroundColor = [UIColor lightGrayColor];
        [self.view addSubview:maskView];
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"该页面不可操作，亲～你可能还未绑定设备哦" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];
    }else{

        [self updateAlertInfo];
       
    }
    
}
#pragma mark-----UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_devicesTotalArr exchangeObjectAtIndex:0 withObjectAtIndex:buttonIndex];
    [self updateAlertInfo];
    
    NSLog(@"%d" ,buttonIndex);
}

@end
