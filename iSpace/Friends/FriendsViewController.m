//
//  FriendsViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsCell.h"
#import "friendsInfoModel.h"
#import "AddFriendsViewController.h"

@interface FriendsViewController ()

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
    [super viewDidLoad];
    
     UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriendsAction:)];
    self.navigationItem.rightBarButtonItem = barButtonItem ;
    
    [_friendTableView registerNib:[UINib nibWithNibName:@"FriendsCell" bundle:nil] forCellReuseIdentifier:@"FriendsCell"];
    [self setExtraCellLineHidden:_friendTableView];
    
    //获取好友信息列表
    _friendsModelArr = [[NSMutableArray alloc]initWithCapacity:10];
    [self getFriendsList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
    AddFriendsViewController *addFriendsViewCtl = [[AddFriendsViewController alloc]init];
    [self.navigationController pushViewController:addFriendsViewCtl animated:YES];
}
#pragma mark-----获取好友列表
- (void)getFriendsList
{
    NSMutableDictionary *dict = [NetDataService needCommand:@"2082" andNeedUserId:USER_ID AndNeedBobyArrKey:NULL andNeedBobyArrValue:NULL];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"loading" andViewCtl:self completeBlock:^(id result){
        
        NSDictionary *returnDict = result[@"message_body"];
        if ([returnDict[@"error"] intValue] == 0) {
            for (NSDictionary *friendsDict in returnDict[@"list"])
            {
               FriendsInfoModel *friendsModel = [[FriendsInfoModel alloc]initWithDataDic:friendsDict];
                [_friendsModelArr addObject:friendsModel];
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_friendTableView reloadData];
        });
    }];
}
@end
