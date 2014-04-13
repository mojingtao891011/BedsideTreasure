//
//  AccountViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import "AccountTableViewCell.h"

@interface AccountViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accountTableView;
@property(nonatomic , retain)NSArray *dataSourceArr ;
@property (strong, nonatomic) IBOutlet UITableViewCell *exitButtonCell;
- (IBAction)exitLand:(id)sender;
@end
