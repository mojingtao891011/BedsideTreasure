//
//  SetColckViewControllers.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SetColckViewController.h"
#import "AlarmInfoTableViewCell.h"
#import "MusicModel.h"

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
    [self getRingListInfo];
    [self registerNibCell];
    
}
- (void)registerNibCell
{
    [_setAlarmTabelView registerNib:[UINib nibWithNibName:@"AlarmInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlarmInfoTableViewCell"];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitAlarmInfo:) name:@"AlarmInfo" object:nil];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
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
    alarmInfoCell.listTitleArr = [_listArr mutableCopy];
    
    return alarmInfoCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 255.0 ;
}
#pragma mark-----提交闹钟设置信息
- (void)submitAlarmInfo:(NSNotification*)note
{
    
    NSString *dateStr = [self stringFromFomate:_datepickView.date formate:@"HH:mm"] ;
    //以":"切割
    NSArray *dateArr = [dateStr componentsSeparatedByString:@":"];
    NSString *hour = dateArr[0];
    NSString *minute = dateArr[1];
    
    NSMutableArray *infoArr = [note object];
    NSString *frequency = infoArr[0] ;
    NSString *vol_level = infoArr[1] ;
    NSString *vol_type = infoArr[2] ;
    NSString *file_path = infoArr[3] ;
    NSString *file_id = infoArr[4] ;
   
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
                          @"fm_chnl":@"0" ,           //FM频道
                          @"file_path":file_path,          //音源路径
                          @"file_id" : file_id             //音源 ID
                          
                          };
    
    NSMutableDictionary *dict = [NetDataService needCommand:@"2052" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn" , @"alarm_info"] andNeedBobyArrValue:@[DEV_SN , dic]];
//    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"loading" andViewCtl:self completeBlock:^(id result){
//        NSLog(@"%@" , result);
//    }];

}
#pragma mark-----将NSDate转化为NSString
- (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate
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

}
@end
