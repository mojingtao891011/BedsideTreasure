//
//  SetColckViewControllers.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SetColckViewController.h"
#import "AlarmInfoTableViewCell.h"
#import "RecordModel.h"

@interface SetColckViewController ()

@end

@implementation SetColckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"设置闹钟" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
<<<<<<< HEAD
    [self getRingListInfo];
=======
     _fmArr = [[NSMutableArray alloc]initWithCapacity:10];
    _recordArr = [[NSMutableArray alloc]initWithCapacity:10];
    
    [self getRecordInfo];
>>>>>>> FETCH_HEAD
    [self registerNibCell];
    
}
- (void)registerNibCell
{
    [_setAlarmTabelView registerNib:[UINib nibWithNibName:@"AlarmInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlarmInfoTableViewCell"];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
<<<<<<< HEAD
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitAlarmInfo:) name:@"AlarmInfo" object:nil];
    
=======
>>>>>>> FETCH_HEAD
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitAlarmInfo:) name:@"AlarmInfo" object:nil];
    
    
}
- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmInfoTableViewCell *alarmInfoCell = [tableView dequeueReusableCellWithIdentifier:@"AlarmInfoTableViewCell"];
    
    alarmInfoCell.pushViewCtl = self ;
    alarmInfoCell.FMArr = [_fmArr mutableCopy];
    alarmInfoCell.recordArr = [_recordArr mutableCopy];
    
    return alarmInfoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 255.0 ;
}
<<<<<<< HEAD
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmInfoTableViewCell *alarmInfoCell = [tableView dequeueReusableCellWithIdentifier:@"AlarmInfoTableViewCell"];
    
    alarmInfoCell.pushViewCtl = self ;
    alarmInfoCell.listTitleArr = [_listArr mutableCopy];
    
    return alarmInfoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 255.0 ;
}
#pragma mark-----提交闹钟设置信息
=======
#pragma mark-----提交闹钟设置信息(note)
>>>>>>> FETCH_HEAD
- (void)submitAlarmInfo:(NSNotification*)note
{
    
    NSString *dateStr = [self stringFromFomate:_datepickView.date formate:@"HH:mm"] ;
    //以":"切割
    NSArray *dateArr = [dateStr componentsSeparatedByString:@":"];
    NSString *hour = dateArr[0];
    NSString *minute = dateArr[1];
<<<<<<< HEAD
    
=======
    //频率、音量 、铃音类型 、FM频道 、音源路径 、音源 ID
>>>>>>> FETCH_HEAD
    NSMutableArray *infoArr = [note object];
    NSString *frequency = infoArr[0] ;
    NSString *vol_level = infoArr[1] ;
    NSString *vol_type = infoArr[2] ;
<<<<<<< HEAD
    NSString *file_path = infoArr[3] ;
    NSString *file_id = infoArr[4] ;
=======
    NSString *fm_chnl = infoArr[3];
    NSString *file_path = infoArr[4] ;
    NSString *file_id = infoArr[5] ;
>>>>>>> FETCH_HEAD
   
    //把设置信息保存到网络
    NSDictionary *dic = @{
                          @"index": [NSString stringWithFormat:@"%d" , _clockButtonTag],        //闹钟的索引值
                          @"state":@"1" ,                 //闹钟的开关状态
                          @"frequency": frequency ,       //频率
                          @"sleep_times":@"0" ,     //睡眠次数  
                          @"sleep_gap": @"0" ,      //睡眠间隔
                          @"hour":hour ,                //时
                          @"minute": minute ,       //分
                          @"vol_level":vol_level ,  //音量
                          @"vol_type": vol_type ,         //铃音类型0 为语音;1 为音乐;2 为 FM;3 为系统
<<<<<<< HEAD
                          @"fm_chnl":@"0" ,           //FM频道
=======
                          @"fm_chnl":fm_chnl,           //FM频道
>>>>>>> FETCH_HEAD
                          @"file_path":file_path,          //音源路径
                          @"file_id" : file_id             //音源 ID
                          
                          };
    
    NSMutableDictionary *dict = [NetDataService needCommand:@"2052" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn" , @"alarm_info"] andNeedBobyArrValue:@[DEV_SN , dic]];
<<<<<<< HEAD
//    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"loading" andViewCtl:self completeBlock:^(id result){
//        NSLog(@"%@" , result);
//    }];
=======
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@" , result);
        int errorInt = [result[@"message_body"][@"error"] intValue];
        if (errorInt == 0) {
            UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:nil message:@"闹钟设置成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
            [alertView show];
        }else{
            UIAlertView *alertView =[ [UIAlertView alloc]initWithTitle:nil message:@"闹钟设置失败，您到闹钟可能离线" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] ;
            [alertView show];
        }
        
    }];
>>>>>>> FETCH_HEAD

}
#pragma mark-----将NSDate转化为NSString
- (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate
<<<<<<< HEAD
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}
#pragma mark-----从网络获取音乐、FM、录音
- (void)getRingListInfo
{
    //获取音乐
    NSMutableDictionary *musicDict = [NetDataService needCommand:@"2074" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"req_id"] andNeedBobyArrValue:@[@""]];
    [NetDataService requestWithUrl:URl dictParams:musicDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        int errorInt = [result[@"message_body"][@"error"] intValue];
        if (errorInt == 0 && [result[@"message_body"][@"info"] isKindOfClass:[NSArray class]]) {
            
            NSArray *musicInfoArr = result[@"message_body"][@"info"] ;
            MusicModel *musicModel = [[MusicModel alloc]initWithDataDic:musicInfoArr[0]];
            if (_listArr == nil) {
                _listArr = [[NSMutableArray alloc]initWithCapacity:10];
            }
            [_listArr addObject:musicModel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_setAlarmTabelView reloadData];
            });
        }
    }];
//    //获取FM
//    NSMutableDictionary *FMDict = [NetDataService needCommand:@"2053" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn"] andNeedBobyArrValue:@[DEV_SN]];
//    [NetDataService requestWithUrl:URl dictParams:FMDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
//        NSLog(@"%@" , result);
//    }];
//    //获取语音
//    NSMutableDictionary *recordDict = [NetDataService needCommand:@"2075" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"req_id"] andNeedBobyArrValue:@[@""]];
//    [NetDataService requestWithUrl:URl dictParams:recordDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
//        NSLog(@"%@" , result);
//    }];
=======
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}
#pragma mark-----从网络获取音乐、FM、录音
- (void)getRecordInfo
{
    //获取语音
    NSMutableDictionary *musicDict = [NetDataService needCommand:@"2074" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"req_id"] andNeedBobyArrValue:@[@""]];
    [NetDataService requestWithUrl:URl dictParams:musicDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
        int errorInt = [result[@"message_body"][@"error"] intValue];
        int totalInt = [result[@"message_body"][@"total"] intValue];
        if (errorInt == 0 && totalInt != 0) {
            NSArray *musicInfoArr = result[@"message_body"][@"info"] ;
            for (NSDictionary *musicDict in musicInfoArr) {
                RecordModel *recordModel = [[RecordModel alloc]initWithDataDic:musicDict];
                [_recordArr addObject:recordModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_setAlarmTabelView reloadData];
                [self getFMInfo];
                
            });
        }
    }];
    
}
- (void)getFMInfo
{
    //获取FM
    NSMutableDictionary *FMDict = [NetDataService needCommand:@"2053" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn"] andNeedBobyArrValue:@[DEV_SN]];
    [NetDataService requestWithUrl:URl dictParams:FMDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
        int errorInt = [result[@"message_body"][@"error"] intValue];
        int totalInt = [result[@"message_body"][@"fm_info"][@"total"] intValue];
        if (errorInt == 0 && totalInt != 0) {
            NSArray *FMlist = result[@"message_body"][@"fm_info"][@"list"];
            for (NSString *FMChannel in FMlist) {
                    [_fmArr addObject:FMChannel];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_setAlarmTabelView reloadData];
           
        });
    }];
>>>>>>> FETCH_HEAD

}
@end
