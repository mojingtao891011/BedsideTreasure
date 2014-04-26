//
//  FriendsViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface FriendsViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
@property(nonatomic , retain)NSMutableArray *friendsModelArr ;

@end
