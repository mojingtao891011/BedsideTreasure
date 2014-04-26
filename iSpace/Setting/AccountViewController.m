//
//  AccountViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AccountViewController.h"
#import "LoginViewController.h"
#import "AccountTableViewCell.h"

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
    
    [self loadUserInfo];
    [self.accountTableView registerNib:[UINib nibWithNibName:@"AccountTableViewCell" bundle:nil] forCellReuseIdentifier:@"AccountTableViewCell"];
    self.dataSourceArr = @[@"头像" , @"用户名" , @"性别" , @"生日" , @"城市" , @"绑定手机" , @"绑定邮箱" , @"密码保护" ,@"更改密码" , @"手势密码" ];
    for (NSString *key in _dataSourceArr) {
        if (_userInfoDict == nil) {
            _userInfoDict = [[NSMutableDictionary alloc]initWithCapacity:10];
        }
        [_userInfoDict setObject:@"" forKey:key];
    }
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
        }else{
           accountCell.valueLabel.text = _userInfoDict[_dataSourceArr[indexPath.row]];
        }

        return accountCell ;
    }
    return _exitButtonCell ;
}
#pragma mark-----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 60 ;
    }
    return 44 ;
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
#pragma mark-----获取用户信息
- (void)loadUserInfo{
    //请求体
    NSMutableDictionary *Dict = [NetDataService needCommand:@"2063" andNeedUserId:@"0" AndNeedBobyArrKey:@[@"account"] andNeedBobyArrValue:@[USERNAME]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:Dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"Loading" andViewCtl:self completeBlock:^(id result){
        NSLog(@"%@", result);
        NSDictionary *retrunDict = result[@"message_body"] ;
        NSString *errorInt = retrunDict[@"error"];
        if (errorInt.intValue != 0 ) {
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该用户尚未注册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alerView show];
            return ;
        }
        //保存用户信息到用户信息模型
        _userInfoModel = [[UserInfoModel alloc]initWithDataDic:retrunDict];
        NSString *birthday =[NSString stringWithFormat:@"%@.%@.%@",_userInfoModel.year , _userInfoModel.month , _userInfoModel.day];
        NSArray*userInfoArr = @[_userInfoModel.name , _userInfoModel.sex , birthday , _userInfoModel.city , _userInfoModel.phone_no , _userInfoModel.email , @"" , @"" , @"是"] ;

        for (int i = 1; i < _dataSourceArr.count; i++) {
            [_userInfoDict setObject:userInfoArr[i-1] forKey:_dataSourceArr[i]];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [_accountTableView reloadData];
            
        });
    }];
}
#pragma mark--------点击退出按钮时
- (IBAction)exitLand:(UIButton*)sender {
    
    //改变button的背景色
    [sender setBackgroundColor:buttonSelectedBackgundColor];
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2054" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"cause"] andNeedBobyArrValue:@[ @"0" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"Exiting" andViewCtl:self completeBlock:^(id result){
        NSDictionary *returnDict = result[@"message_body"];
        int  returnError = [returnDict[@"error"] intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self returnInfo:returnError];
        });
    }];
}
- (void)returnInfo:(int)errorInt
{
    if (errorInt == 0) {
        LoginViewController *exitloginViewCtl = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:exitloginViewCtl animated:YES];
    }
}
@end
