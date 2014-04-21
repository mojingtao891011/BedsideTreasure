//
//  LookPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "LookPassWordViewController.h"
#import "LookStyleViewController.h"

@interface LookPassWordViewController ()

@end

@implementation LookPassWordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"找回密码" ;
        [self.titleLabel sizeToFit] ;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArr = @[@"" , @""] ;
    
    //一开始就主动请求获取用户信息
     [self startNetwork];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator ;
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(10, 43, tableView.width-20, 1)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 13, 0, 20)];
        titleLabel.tag = 11 ;
        [cell.contentView addSubview:titleLabel];
    }
    UILabel *label = (UILabel*)[cell viewWithTag:11];
    label.text = _titleArr[indexPath.row] ;
    [label sizeToFit];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor lightGrayColor];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LookStyleViewController *lookStyleViewCtl = [[LookStyleViewController alloc]init];
    lookStyleViewCtl.userInfoModel = _userInfoModel ;
    lookStyleViewCtl.searchStyle = [NSString stringWithFormat:@"%d" , indexPath.row] ;
    [self.navigationController pushViewController:lookStyleViewCtl animated:YES];

   
}
#pragma mark-----customAction
#pragma mark-----请求网络数据（获取用户信息）
- (void)startNetwork
{
    //请求体
    NSMutableDictionary *Dict = [NetDataService needCommand:@"2063" andNeedUserId:@"0" AndNeedBobyArrKey:@[@"account"] andNeedBobyArrValue:@[_userName]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"Loading" andViewCtl:self completeBlock:^(id result){
        
        NSDictionary *retrunDict = result[@"message_body"] ;
        NSString *errorInt = retrunDict[@"error"];
        if (errorInt.intValue != 0 ) {
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该用户尚未注册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerView show];
            return ;
        }
        //保存用户信息到用户信息模型
        _userInfoModel = [[UserInfoModel alloc]initWithDataDic:retrunDict];
        //保存用户ID
        NSDictionary *headDict = result[@"message_head"] ;
        NSString *userID = headDict[@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:userID forKey:@"uid"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _titleArr = @[@"使用手机号重设密码" , @"使用邮箱地址重设密码"] ;
            [_lookPassWordTableView reloadData];
        });

    }];
   
}
#pragma mark------UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
