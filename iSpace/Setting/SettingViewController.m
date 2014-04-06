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
#import "AboutViewController.h"

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
    self.dataSourceArr = @[@"账号设置" , @"帮助" , @"关于"] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----UITableViewDataSource
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d" , indexPath.row);
    if (indexPath.row == 0) {
        AccountViewController *accountViewCtl = [[AccountViewController alloc]init];
        [self.navigationController pushViewController:accountViewCtl animated:YES];
    }
    else if(indexPath.row == 1){
        HelpViewController *helpViewCtl = [[HelpViewController alloc]init];
        [self.navigationController pushViewController:helpViewCtl animated:YES];
    }
    else if (indexPath.row == 2){
        AboutViewController *aboutViewCtl = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:aboutViewCtl animated:YES];
    }
    
}
@end
