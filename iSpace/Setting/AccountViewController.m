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
#import "BingPhoneViewController.h"
#import "BingEmailViewController.h"
#import "ChangePasswordViewController.h"
#import "CityListViewController.h"
#import "UIImageView+WebCache.h"

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
    [self setExtraCellLineHidden:_accountTableView];
    
<<<<<<< HEAD
    self.dataSourceArr = @[@"头像" , @"用户名" , @"性别" , @"生日" , @"城市" , @"绑定手机" , @"绑定邮箱"  ,@"更改密码" , @"手势密码" ];
    
=======
    self.dataSourceArr = @[@"头像" , @"用户名" , @"性别" , @"生日" , @"城市" , @"绑定手机" , @"绑定邮箱"  ,@"更改密码"  ];
    
    //添加保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setFrame:CGRectMake(20, 0, 50, 20)];
    [saveButton setTitle:@"保 存" forState:UIControlStateNormal];
    [saveButton setTitle:@"保 存" forState:UIControlStateSelected];
    [saveButton addTarget:self action:@selector(saveUserInfo:) forControlEvents:UIControlEventTouchUpInside ];
    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc]initWithCustomView:saveButton];
    self.navigationItem.rightBarButtonItem = saveBarButton ;
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedSexNote:) name:@"selectedSexNote" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedCityNote:) name:@"selectedCityNote" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTableView:) name:REFRESHTABLEVIEW object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _dateBgView.hidden = YES ;
    _markView.hidden = YES ;
    //[[NSNotificationCenter defaultCenter]removeObserver:self];
>>>>>>> FETCH_HEAD
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark-----保存修改
- (void)saveUserInfo:(UIButton*)saveButton
{
    NSLog(@"%@ , %@ , %@" , _birthday , _sex , _city);
        [self saveUserInfoAction:_birthday andSex:_sex andCity:_city];

}
#pragma mark-----note
- (void)selectedSexNote:(NSNotification*)note
{
    _sex = [note object];
    [_accountTableView reloadData];

}
- (void)selectedCityNote:(NSNotification*)cityNote
{
    [_userInfoArr replaceObjectAtIndex: 4 withObject:[cityNote object]];
    _city = [cityNote object];
    [_accountTableView reloadData];
}
- (void)refreshTableView:(NSNotification*)note
{
    NSArray *noteArr = [note object];
    int index = [noteArr[1] intValue];
    [_userInfoArr replaceObjectAtIndex:index  withObject:noteArr[0]];
    [_accountTableView reloadData];
}
#pragma mark----- 此页面保存、性别、生日、城市
- (void)saveUserInfoAction:(NSString*)userBirthday andSex:(NSString*)userSex andCity:(NSString*)userCity
{
    NSString *bsae64City =[[NSString alloc]initWithData:[GTMBase64 encodeData:[userCity dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
    //以"-"切割
    NSArray *birthdayArr = [userBirthday componentsSeparatedByString:@"-"];
    
    NSDictionary *accInfoDict = @{
                                  @"name": USERNAME,
                                  @"email":@"",
                                  @"phone_no":@"",
                                  @"uid":USER_ID
                                  };
    NSDictionary *baseDict = @{
                               @"acc_info": accInfoDict,
                               @"sex" :userSex ,
                               @"city" :bsae64City ,
                               @"pic_url":@"",
                               @"pic_id" :@"-1"
                               };
    NSDictionary *birthdayDict = @{
                                   @"year": birthdayArr[0],
                                   @"month":birthdayArr[1],
                                   @"day":birthdayArr[2]
                                   };
    NSDictionary *infoDict = @{
                               @"base_info": baseDict ,
                               @"password":@"",
                               @"birthday" :birthdayDict,
                               };
    NSMutableDictionary *dict = [NetDataService needCommand:@"2057" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"info" , @"password" , @"req_id"] andNeedBobyArrValue:@[infoDict ,  @"" , @"-1"]];
    
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
    }];
}

#pragma mark-----UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
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
    if (indexPath.section == 1) {
        
            return _exitButtonCell ;
       
    }
    AccountTableViewCell *accountCell = [tableView dequeueReusableCellWithIdentifier:@"AccountTableViewCell"];
    if (indexPath.row == 0) {
<<<<<<< HEAD
        accountCell.valueLabel.hidden = YES ;
        [self drawUserImageView:accountCell];
=======
        accountCell.titleLabel.hidden = YES ;
        accountCell.valueLabel.hidden = YES ;
        UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 25, 50, 20)];
        [accountCell.contentView addSubview:userLabel];
        userLabel.text = _dataSourceArr[indexPath.row];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(accountCell.width - 100, 2, 60, 60)];
        imageView.backgroundColor = [UIColor redColor] ;
        imageView.layer.cornerRadius = 30 ;
        imageView.layer.borderWidth = 2 ;
        imageView.layer.masksToBounds = YES ;
       imageView.layer.borderColor = buttonBackgundColor.CGColor ;
        [imageView setImageWithURL:[NSURL URLWithString:_pic_url] placeholderImage:[UIImage imageNamed:@"ic_test_head"]];
        [accountCell.contentView addSubview:imageView];
        
>>>>>>> FETCH_HEAD
    }else if(indexPath.row == 2){
        accountCell.radioButton.hidden = NO ;
        accountCell.bodyLabel.hidden = NO ;
        accountCell.radioButton_b.hidden = NO ;
        accountCell.girlLabel.hidden = NO ;
         accountCell.valueLabel.hidden = YES ;
<<<<<<< HEAD
    }
=======
        accountCell.selectionStyle = UITableViewCellSelectionStyleNone ;
    }
    
>>>>>>> FETCH_HEAD
    if (indexPath.row > 4) {
        accountCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
    }else{
        accountCell.accessoryType = UITableViewCellAccessoryNone ;
    }
<<<<<<< HEAD
    if ([_userInfoModel.sex isEqualToString:@"0"]) {
        accountCell.radioButton_b.selected = YES ;
    }else if ([_userInfoModel.sex isEqualToString:@"1"]){
        accountCell.radioButton.selected = YES ;
    }
    if (indexPath.row == 3 || indexPath.row == 4) {
        accountCell.pushButton.hidden = NO ;
    }
    accountCell.titleLabel.text = _dataSourceArr[indexPath.row];
    accountCell.valueLabel.text = _userInfoArr[indexPath.row];
=======
    
    if (indexPath.row == 3 || indexPath.row == 4) {
        accountCell.pushButton.hidden = NO ;
    }
    
    accountCell.titleLabel.text = _dataSourceArr[indexPath.row];
    accountCell.valueLabel.text = _userInfoArr[indexPath.row];
    accountCell.selectedSex = _sex ;
    
>>>>>>> FETCH_HEAD
    return accountCell ;
    
}
#pragma mark-----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
<<<<<<< HEAD
    if (indexPath.row == 3) {
        
=======
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIActionSheet *actionsheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"用户相册", nil];
        [actionsheet showInView:self.view];
    }
    if (indexPath.row == 3)
    {
        _dateBgView.hidden = NO ;
        _markView.hidden = NO ;
        _dateBgView.layer.cornerRadius = 5.0 ;
        NSLocale *locales = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _datePicker.locale = locales ;
        [self.view bringSubviewToFront:_dateBgView];
       
    }
    else if (indexPath.row == 4)
    {
        CityListViewController *cityListViewCtl = [[CityListViewController alloc]init];
        [self.navigationController pushViewController:cityListViewCtl animated:YES];
    }
    else if(indexPath.row == 5)
    {
        BingPhoneViewController *bingViewCtl = [[BingPhoneViewController alloc]init];
        [self.navigationController pushViewController:bingViewCtl animated:YES];
    }
    else if (indexPath.row == 6)
    {
        BingEmailViewController *bingEmaiViewCtl = [[BingEmailViewController alloc]init];
        [self.navigationController pushViewController:bingEmaiViewCtl animated:YES];
    }
    else if (indexPath.row == 7)
    {
        ChangePasswordViewController *changePasswordViewCtl = [[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:changePasswordViewCtl animated:YES] ;
>>>>>>> FETCH_HEAD
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 60 ;
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 65 ;
    }
    return 44 ;
}
//UITableView隐藏多余的分割线
<<<<<<< HEAD
- (void)setExtraCellLineHidden: (UITableView *)tableView{
=======
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
>>>>>>> FETCH_HEAD
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
<<<<<<< HEAD

- (void)drawUserImageView : (AccountTableViewCell*)cell
=======
#pragma mark-----UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
>>>>>>> FETCH_HEAD
{
    
    UIImagePickerControllerSourceType sourceType ; //照片类型（是结构体）
    if (buttonIndex == 0) {
        //判断是否有摄像头
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:nil message:@"此设备没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alerView show];
            return ;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera ;
    }else if (buttonIndex == 1){
        //用户相册
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary ;
        
    }else if (buttonIndex == 2){
        //取消
        return ;
    }
    UIImagePickerController  *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.sourceType = sourceType ;
    imagePicker.delegate = self ;
    [self presentViewController:imagePicker animated:YES completion:nil];
    
}
#pragma mark-----UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _userImage = info[@"UIImagePickerControllerOriginalImage"];
    NSData *imgData = UIImageJPEGRepresentation(_userImage, 0.3);
    
    //获取上传地址
    NSMutableDictionary *imgDict = [NetDataService needCommand:@"2056" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"filename" , @"type" , @"size" , @"req_id" , @"set"] andNeedBobyArrValue:@[@"11", @".png" , @"10" , @"-1" , @"1"]];
    [NetDataService requestWithUrl:URl dictParams:imgDict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
        
        int errorInt = [result[@"message_body"][@"error"] intValue];
        if (errorInt == 0) {
           //拼接上传地址 @"http://115.29.199.95:23000/iSpaceSvr/?cmd=3000&uid=79&fid=631&uts=1399448645&rid=-1&tpn=0"
            NSString *host = result[@"message_body"][@"host"] ;
            NSString *port = result[@"message_body"][@"port"] ;
            NSString *param = result[@"message_body"][@"param"] ;
            _appendUrl = [NSString stringWithFormat:@"http://%@:%@/iSpaceSvr/?%@" , host , port , param];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //通过拼接上传地址获取_pic_url 、_pic_id
            [NetDataService requestWithUrl:_appendUrl postData:imgData httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtls:self completeBlock:^(id result){
                
                _pic_url = result[@"message_body"][@"url"];
                _pic_id = result[@"message_body"][@"fileid"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    //保存用户头像到服务器
                    NSDictionary *accInfoDict = @{
                                                  @"name": USERNAME,
                                                  @"email":@"",
                                                  @"phone_no":@"",
                                                  @"uid":USER_ID
                                                  };
                    NSDictionary *baseDict = @{
                                               @"acc_info": accInfoDict,
                                               @"sex" :@"-1",
                                               @"city" :@"" ,
                                               @"pic_url":_pic_url,
                                               @"pic_id" :_pic_id
                                               };
                    NSDictionary *birthdayDict = @{
                                                   @"year": @"-1",
                                                   @"month":@"-1",
                                                   @"day":@"-1"
                                                   };
                    NSDictionary *infoDict = @{
                                               @"base_info": baseDict ,
                                               @"password":@"",
                                               @"birthday" :birthdayDict,
                                               };
                    NSMutableDictionary *dict = [NetDataService needCommand:@"2057" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"info" , @"password" , @"req_id"] andNeedBobyArrValue:@[infoDict ,  @"" , @"-1"]];
                    
                    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:self completeBlock:^(id result){
            
                        int errorInt =[result[@"message_body"][@"error"] intValue];
                        if (errorInt != 0) {
                            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"更换头像失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }else
                        {
                            [_accountTableView reloadData];
                        }
                    }];

                });
            }];
        });
    }];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark-----获取用户信息
- (void)loadUserInfo
{
   
    //请求体
    NSMutableDictionary *Dict = [NetDataService needCommand:@"2063" andNeedUserId:@"0" AndNeedBobyArrKey:@[@"account"] andNeedBobyArrValue:@[USERNAME]];
    
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
<<<<<<< HEAD
        NSString *birthday =[NSString stringWithFormat:@"%@.%@.%@",_userInfoModel.year , _userInfoModel.month , _userInfoModel.day];
        _userInfoArr = @[@"" ,_userInfoModel.name , _userInfoModel.sex , birthday , _userInfoModel.city , _userInfoModel.phone_no , _userInfoModel.email , @"" , @"未设置"];
=======
        _birthday =[NSString stringWithFormat:@"%@-%@-%@",_userInfoModel.year , _userInfoModel.month , _userInfoModel.day];
        _pic_url = _userInfoModel.pic_url ;
        NSString *userName = [[NSString alloc]initWithData:[GTMBase64 decodeString:_userInfoModel.name] encoding:NSUTF8StringEncoding];
        _city = [[NSString alloc]initWithData:[GTMBase64 decodeData:[_userInfoModel.city dataUsingEncoding:NSUTF8StringEncoding]] encoding:NSUTF8StringEncoding];
        _userInfoArr = [NSMutableArray arrayWithObjects:_pic_url ,userName ,  _userInfoModel.sex , _birthday , _city , _userInfoModel.phone_no , _userInfoModel.email , @"", nil];
>>>>>>> FETCH_HEAD
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _sex = _userInfoModel.sex ;
           [_accountTableView reloadData];
            
        });
    }];
}
#pragma mark--------点击退出按钮时
- (IBAction)exitLand:(UIButton*)sender
{
    
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
#pragma mark--------日期选择器“确定”
- (IBAction)EnterDateAction:(id)sender
{
    _dateBgView.hidden = YES ;
    _markView.hidden = YES ;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"YYYY-MM-dd"];
	_birthday = [formatter stringFromDate:_datePicker.date];
    [_userInfoArr replaceObjectAtIndex:3 withObject:_birthday];
    [_accountTableView reloadData];

}
#pragma mark--------日期选择器“取消”
- (IBAction)cancelDateAction:(id)sender
{
    _dateBgView.hidden = YES ;
    _markView.hidden = YES ;

}
@end
