//
//  AccountViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import "UserInfoModel.h"

@interface AccountViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>

@property(nonatomic , retain)NSArray *dataSourceArr ;
@property(nonatomic , retain)NSArray *userInfoArr;
@property(nonatomic , retain)UserInfoModel *userInfoModel ;
@property (strong, nonatomic) IBOutlet UIView *dataPickView;
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *exitButtonCell;
- (IBAction)exitLand:(id)sender;

@end
