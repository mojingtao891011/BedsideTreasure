//
//  HomeViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource ,UITableViewDelegate , UIActionSheetDelegate>

@property(nonatomic , retain)NSMutableArray *devicesTotalArr ;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property(nonatomic , assign)BOOL isSelected ;

@end
