//
//  LookPassWordViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "LookPassWordViewController.h"
#import "PhoneLookPassWordViewController.h"
#import "EmailLookPassWordViewController.h"

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
    _titleArr = @[@"使用手机号重设密码" , @"使用邮箱地址重设密码"] ;
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
    label.textColor = [UIColor lightGrayColor];
    return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
         PhoneLookPassWordViewController *phoneLookViewCtl = [[PhoneLookPassWordViewController alloc]init];
        [self.navigationController pushViewController:phoneLookViewCtl animated:YES];
    }
    else if (indexPath.row == 1){
        EmailLookPassWordViewController *emailLookViewCtl = [[EmailLookPassWordViewController alloc]init];
        [self.navigationController pushViewController:emailLookViewCtl animated:YES];
    }
   
}
@end
