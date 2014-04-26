//
//  AddFriendsViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "SearchListCell.h"
#import "FriendsInfoModel.h"

@interface AddFriendsViewController ()

@end

@implementation AddFriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"添加好友" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _friendsArr = [[NSMutableArray alloc]initWithCapacity:20];
    [self searFriendsAction:nil];
    
    [_searchListTableView registerNib:[UINib nibWithNibName:@"SearchListCell" bundle:nil] forCellReuseIdentifier:@"SearchListCell"];
    [self setExtraCellLineHidden:_searchListTableView];
    [_searchListTableView setTableHeaderView:_searchView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
#pragma mark-----UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _friendsArr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchListCell *searchListCell = [tableView dequeueReusableCellWithIdentifier:@"SearchListCell"];
    searchListCell.friendsInfoModel = _friendsArr[indexPath.row];
    return searchListCell ;
}
#pragma mark-----UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60 ;
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
#pragma mark----- UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES ;
}
#pragma mark----- 查找好友
- (IBAction)searFriendsAction:(id)sender {
    
    [_friendsName resignFirstResponder];
    
    if (_friendsName.text != 0) {
        [_friendsArr removeAllObjects];
    }
    
    NSMutableDictionary *dict = [NetDataService needCommand:@"2068" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"account"] andNeedBobyArrValue:@[_friendsName.text]];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:@"正在搜索……" andViewCtl:self completeBlock:^(id result){
        NSArray *returnArr = result[@"message_body"][@"list"];
        for (NSDictionary *dict in returnArr) {
            FriendsInfoModel *friendsInfoModel = [[FriendsInfoModel alloc]initWithDataDic:dict];
            [_friendsArr addObject:friendsInfoModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_searchListTableView reloadData];
            
        });
    }];

    

}
@end
