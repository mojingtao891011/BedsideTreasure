//
//  HelpViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
    self.dataSourceArr = @[@"基本介绍" , @"注册/登录" , @"账号安全" , @"忘记密码" , @"iSpace" , @"下载安装" , @"功能问题" , @"支付购买" ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourceArr.count ;
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
        titleLabel.tag = 12 ;
        titleLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor clearColor] ;
        [cell.contentView addSubview:titleLabel];
    }
    UILabel *label = (UILabel*)[cell viewWithTag:12];
    label.text = _dataSourceArr[indexPath.row] ;
    [label sizeToFit];
    label.textColor = FontColor;
    return cell ;
}

@end
