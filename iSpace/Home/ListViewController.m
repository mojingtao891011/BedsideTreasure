//
//  ListViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-14.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ListViewController.h"
#import "MusicModel.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _listArr = [[NSMutableArray alloc]initWithCapacity:10];
    
    if ([self.titleLabel.text isEqualToString:@"音乐列表"]) {
        [self getMusicList];
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"]) {
        [self getRecordList];
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"]) {
        [self getFMList];
    }
   
    [self setExtraCellLineHidden:_listTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    if ([self.titleLabel.text isEqualToString:@"音乐列表"])
    {
         MusicModel *model = _listArr[indexPath.row];
         cell.textLabel.text =model.musicName;
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"])
    {
        
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"])
    {
        cell.textLabel.text =_listArr[indexPath.row] ;
    }
    cell.imageView.image = [UIImage imageNamed:@"bt_play"];
   
    
    return cell ;
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark-----customAction
- (void)getFMList
{
   
    NSMutableDictionary *dict = [NetDataService needCommand:@"2053" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"dev_sn"] andNeedBobyArrValue:@[DEV_SN]];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
         int errorInt = [result[@"message_body"][@"error"] intValue];
        if (errorInt == 0) {
            _listArr = result[@"message_body"][@"fm_info"][@"list"];
        }
        dispatch_async(dispatch_get_main_queue(),^{
            [_listTableView reloadData];
        });
    }];
}
- (void)getMusicList
{
    NSMutableDictionary *dict = [NetDataService needCommand:@"2074" andNeedUserId:USER_ID AndNeedBobyArrKey:nil andNeedBobyArrValue:nil];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        int errorInt = [result[@"message_body"][@"error"] intValue];
        if (errorInt == 0) {
            NSArray *musicInfoArr = result[@"message_body"][@"info"] ;
            for (NSDictionary *dict in musicInfoArr) {
                MusicModel *musicModel = [[MusicModel alloc]initWithDataDic:dict];
                [_listArr addObject:musicModel];
            }
            MusicModel *model = _listArr[0];
            [MusicModel sharedManager].musicName = model.musicName ;
            [MusicModel sharedManager].musicUrl = model.musicUrl ;
            [MusicModel sharedManager].musicId = model.musicId ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_listTableView reloadData];
            if (errorInt != 0) {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"友情提示" message:@"音乐列表为空" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                [alertView show];
            }
        });
        
    }];

}
- (void)getRecordList
{
    NSMutableDictionary *dict = [NetDataService needCommand:@"2075" andNeedUserId:USER_ID AndNeedBobyArrKey:nil andNeedBobyArrValue:nil];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@" , result);
    }];

}
@end
