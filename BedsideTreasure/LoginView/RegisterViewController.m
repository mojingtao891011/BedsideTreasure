//
//  RegisterViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegiterTableViewCell.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"注册" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self _initRegisterTableView];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO ;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-----UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}

- (void)_initRegisterTableView
{
    _titleArr = @[@"用户名", @"密码", @"确认密码", @"邮箱", @"手机"];
    _registerTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, _titleArr.count * 44 + 44) style:UITableViewStylePlain];
    _registerTableView.dataSource = self ;
    _registerTableView.delegate = self ;
    [self.view addSubview: _registerTableView];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegiterTableViewCell" bundle:nil] forCellReuseIdentifier:@"RegiterCell"];
    
    NSLog(@"%f" , _registerTableView.rowHeight);
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count ;
   
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    RegiterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegiterCell"];
    cell.titleLabel.text = _titleArr[indexPath.row] ;
    return cell ;
      //  explainLabel.text = @"已阅读并同意使用条款和隐私政策" ;
}
@end
