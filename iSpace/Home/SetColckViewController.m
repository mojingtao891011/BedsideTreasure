//
//  SetColckViewControllers.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SetColckViewController.h"
#import "DatePickTableViewCell.h"
#import "AlarmInfoTableViewCell.h"


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
    [self registerNibCell];
    
}
- (void)registerNibCell
{
    [_setAlarmTabelView registerNib:[UINib nibWithNibName:@"DatePickTableViewCell" bundle:nil] forCellReuseIdentifier:@"DatePickTableViewCell"];
     [_setAlarmTabelView registerNib:[UINib nibWithNibName:@"AlarmInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"AlarmInfoTableViewCell"];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(submitAlarmInfo:) name:@"postAlarmInfo" object:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)submitAlarmInfo:(NSNotification*)note
{
    NSMutableArray *infoArr = [note object];
    //以":"切割
    NSArray *dateArr = [[infoArr lastObject] componentsSeparatedByString:@":"];
    NSString *hour = dateArr[0];
    NSString *minute = dateArr[1];
    //把设置信息保存到网络
    NSDictionary *dic = @{
                          @"index": [NSString stringWithFormat:@"%d" , _clockButtonTag],
                          @"state":@"1" ,
                          @"frequency": @"3" ,
                          @"sleep_times":@"0" ,
                          @"sleep_gap": @"0" ,
                          @"hour":hour ,
                          @"minute": minute ,
                          @"vol_level":@"0" ,
                          @"vol_type": @"1" ,
                          @"fm_chnl":@"0" ,
                          @"file_path":@"0"
                          };
    
    NSMutableDictionary *dict = [NetDataService needCommand:@"2052" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn" , @"alarm_info"] andNeedBobyArrValue:@[DEV_SN , dic]];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"loading" andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@" , result);
    }];

}
#pragma mark-----UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DatePickTableViewCell *datePickCell = [tableView dequeueReusableCellWithIdentifier:@"DatePickTableViewCell"];
    AlarmInfoTableViewCell *alarmInfoCell = [tableView dequeueReusableCellWithIdentifier:@"AlarmInfoTableViewCell"];
    NSArray *cellArr = @[datePickCell ,  alarmInfoCell ];
    alarmInfoCell.pushViewCtl = self ;
    
    return cellArr[indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *heightArr = @[@"240" , @"255"  ];
    NSString *height = heightArr[indexPath.row];
    return [height floatValue] ;
}
@end
