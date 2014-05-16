//
//  FriendsViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "FriendsViewController.h"
#import "DevicesInfo.h"
#import "DevicesInfoModel.h"

@interface FriendsViewController ()
{
    AppDelegate *dele ;
    NSMutableArray *devicesTotalArr ;
}
@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"好友" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    devicesTotalArr = [[NSMutableArray alloc]initWithCapacity:5];
    dele = [UIApplication sharedApplication].delegate ;
    
   // [self updateDevices];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
<<<<<<< HEAD
#pragma mark----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _friendsModelArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FriendsCell *friendCell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCell"] ;
    friendCell.friendsInfoModel = _friendsModelArr[indexPath.row];
    
    return friendCell ;
}
#pragma mark----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 ;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
    }
}
- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"解除绑定" ;
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
#pragma mark-----customAction（添加好友）
- (void)addFriendsAction:(UIButton*)sender {
    AddFriendsViewController *addFriendsViewCtl = nil ;
    if (addFriendsViewCtl == nil) {
         addFriendsViewCtl = [[AddFriendsViewController alloc]init];
    }
    [self.navigationController pushViewController:addFriendsViewCtl animated:YES];
}
#pragma mark-----获取好友列表
- (void)getFriendsList
{
    NSMutableDictionary *dict = [NetDataService needCommand:@"2082" andNeedUserId:USER_ID AndNeedBobyArrKey:NULL andNeedBobyArrValue:NULL];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"loading" andViewCtl:self completeBlock:^(id result){
        
        NSDictionary *returnDict = result[@"message_body"];
        if ([returnDict[@"error"] intValue] == 0 && [returnDict[@"list"] isKindOfClass:[NSDictionary class]]) {
            for (NSDictionary *friendsDict in returnDict[@"list"])
            {
               FriendsInfoModel *friendsModel = [[FriendsInfoModel alloc]initWithDataDic:friendsDict];
                [_friendsModelArr addObject:friendsModel];
            }
=======
#pragma mark-----登录成功在后台更新设备
-(void)updateDevices
{
    
    //请求体
    NSMutableDictionary *dict = [NetDataService needCommand:@"2051" andNeedUserId:USER_ID AndNeedBobyArrKey:@[ @"dev_type"] andNeedBobyArrValue:@[ @"-1" ]];
    
    //请求网络
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"updateing" andViewCtl:self completeBlock:^(id result){
        
        NSDictionary *returnDict = result[@"message_body"];
        NSString *returnInfo = returnDict[@"error"];
        int returnInt = [returnInfo intValue];
        
        //如果等于0说明有绑定设备
        if (returnInt == 0) {
            NSDictionary *dev_list = returnDict[@"dev_list"];
>>>>>>> FETCH_HEAD
            
            NSArray *listArr = dev_list[@"list"] ;
            for (NSDictionary *deviceDict in listArr) {
                
                 DevicesInfo*devicesInfoModel = [NSEntityDescription insertNewObjectForEntityForName:@"DevicesInfo" inManagedObjectContext:[dele managedObjectContext]];
                devicesInfoModel.dev_city = deviceDict[@"dev_city"];
                devicesInfoModel.dev_idx = deviceDict[@"dev_idx"];
                devicesInfoModel.dev_name = deviceDict[@"dev_name"];
                devicesInfoModel.dev_online = deviceDict[@"dev_online"];
                devicesInfoModel.dev_sn = deviceDict[@"dev_sn"];
                
                [devicesTotalArr addObject:devicesInfoModel];
                [[dele managedObjectContext]save:nil] ;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
        });
    }];
}
<<<<<<< HEAD
=======
- (IBAction)fetchData:(UIButton *)sender
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DevicesInfo" inManagedObjectContext:[dele managedObjectContext]];
    fetchRequest.entity = entity ;
    NSArray *listOfProjects = [[dele managedObjectContext] executeFetchRequest:fetchRequest error:nil];
    if (listOfProjects.count == 0) {
        NSLog(@"no prejects");
    }else{
        [listOfProjects enumerateObjectsUsingBlock:^(id obj , NSUInteger idx , BOOL *stop){
            NSLog(@"%@", [obj dev_name]);
        }];
    }
}
>>>>>>> FETCH_HEAD
@end
