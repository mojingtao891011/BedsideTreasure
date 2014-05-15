//
//  AddMusicViewController.m
//  InAppWebHTTPServer
//
//  Created by 莫景涛 on 14-5-15.
//  Copyright (c) 2014年 AlimysoYang. All rights reserved.
//

#import "AddMusicViewController.h"
#import "WifiViewController.h"


#define GBUnit 1073741824
#define MBUnit 1048576
#define KBUnit 1024

@interface AddMusicViewController ()
@end

@implementation AddMusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setExtraCellLineHidden:_musicTableView];
    
    
    
}
//// 是否wifi
//+ (BOOL) IsEnableWIFI {
//    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
//}
//
//// 是否3G
//+ (BOOL) IsEnable3G {
//    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
//}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getFilePath];
    [_musicTableView reloadData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getFilePath
{
    //获取Document文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    document= [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error ;
    //读取Document目录下内容列表
    listArr = [fileManager contentsOfDirectoryAtPath:document error:&error];
}
#pragma mark-----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return listArr.count ;
    }else
        
    return 1 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return _wifiCell ;
    }
    static NSString *cellID = @"cellID" ;
    UITableViewCell *itemCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (itemCell == nil) {
        itemCell = [[NSBundle mainBundle]loadNibNamed:@"AddMusicCell" owner:self options:nil][0];
    }
    UILabel *fileNameLable = (UILabel*)[itemCell.contentView viewWithTag:2];
    fileNameLable.text = listArr[indexPath.row];
    return itemCell ;
    
}
#pragma mark-----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        WifiViewController *wifiViewCtl = [[WifiViewController alloc]init];
        [self.navigationController pushViewController:wifiViewCtl animated:YES];
        return ;
    }
    NSString *fileName = listArr[indexPath.row];
    NSString *path = [NSString stringWithFormat:@"%@/%@" , document ,fileName] ;
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *data = [fileHandle availableData];
    NSError *error ;
    player = [[AVAudioPlayer alloc]initWithData:data error:&error];
    if (error) {
        NSLog(@"%@" , error);
        return ;
    }
    player.volume = 1.0 ;
    [player prepareToPlay];
    [player play];
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

@end
