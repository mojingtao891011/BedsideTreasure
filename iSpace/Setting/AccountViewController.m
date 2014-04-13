//
//  AccountViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

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
    [self.accountTableView registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountTableViewCell"];
    self.dataSourceArr = @[@"头像" , @"用户名" , @"性别" , @"生日" , @"城市" , @"绑定手机" , @"绑定邮箱" , @"密码保护" ,@"更改密码" , @"手势密码" ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}
#pragma mark-----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.dataSourceArr.count ;
    }
    return 1 ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AccountTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:@"AccountTableViewCell"];
        accountCell.titleLabel.text = self.dataSourceArr[indexPath.row] ;
        if (indexPath.row == 0) {
            [self drawUserImageView:accountCell] ;
            accountCell.valueLabel.alpha = 0.0 ;
        }

        return accountCell ;
    }
    return _exitButtonCell ;
}
- (void)drawUserImageView : (AccountTableViewCell*)cell
{
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake( cell.width - 50.f, 2.f, 40.f, 40.f);
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.width / 2 ;
    imageView.layer.borderWidth = 2 ;
    imageView.layer.borderColor = buttonBackgundColor.CGColor ;
    [cell.contentView addSubview:imageView];
    
    UIImageView * imageView1 = [[UIImageView alloc] init];
    imageView1.width = imageView.width - 8 ,imageView1.height = imageView.height - 8 ;
    [imageView1 setCenter:CGPointMake(imageView.bounds.size.width / 2 , imageView.bounds.size.height / 2 )];
    imageView1.layer.masksToBounds = YES;
    imageView1.layer.cornerRadius = imageView1.width / 2;
    [imageView addSubview:imageView1];
    imageView1.backgroundColor = [UIColor whiteColor];
    imageView1.image = [UIImage imageNamed:@"ic_test_head"];
    
}

- (IBAction)exitLand:(id)sender {
    UIButton *landButton = (UIButton*)sender ;
    [landButton setBackgroundColor:buttonSelectedBackgundColor];
    LoginViewController *exitloginViewCtl = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:exitloginViewCtl animated:YES];
}
@end
