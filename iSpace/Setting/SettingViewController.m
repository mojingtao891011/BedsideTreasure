//
//  SettingViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SettingViewController.h"
#import "AccountViewController.h"
#import "HelpViewController.h"
#import "FeedbackViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"设置" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataSourceArr = @[@"账号设置" , @"帮助" , @"用户协议" , @"版本介绍" , @"检查新版本"  , @"反馈"] ;
    self.imgameArr = @[@"ic_user_setting" , @"ic_help" ,@"ic_agreement" , @"ic_app_introduce" , @"ic_update"  , @"ic_feedback" ];
    [self setExtraCellLineHidden:_settingTableView];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID" ;
    UITableViewCell *setInfoCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (setInfoCell == nil) {
        setInfoCell = [[NSBundle mainBundle]loadNibNamed:@"SettingViewControllerCell" owner:nil options:nil][0];
    }
    UIImageView *imgView = (UIImageView*)[setInfoCell.contentView viewWithTag:1];
    UILabel *titleLabel = (UILabel*)[setInfoCell.contentView viewWithTag:2];
    imgView.image = [UIImage imageNamed:_imgameArr[indexPath.row]];
    titleLabel.text = _dataSourceArr[indexPath.row];
    return setInfoCell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
<<<<<<< HEAD
        AccountViewController *accountViewCtl = nil ;
=======
       static  AccountViewController *accountViewCtl = nil ;
>>>>>>> FETCH_HEAD
        if (accountViewCtl == nil) {
            accountViewCtl = [[AccountViewController alloc]init];
        }
          [self.navigationController pushViewController:accountViewCtl animated:YES];
    }
    else if(indexPath.row == 1){
        HelpViewController *helpViewCtl = nil ;
        if (helpViewCtl == nil) {
            helpViewCtl = [[HelpViewController alloc]init];
        }
        [self.navigationController pushViewController:helpViewCtl animated:YES];
    }
<<<<<<< HEAD
    else if (indexPath.row == 2){
        
        AboutViewController *aboutViewCtl = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutViewCtl animated:YES];
=======
    else if (indexPath.row == 5){
        FeedbackViewController *feedbackCtl = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedbackCtl animated:YES];
>>>>>>> FETCH_HEAD
    }
    
}
@end
