//
//  HelpViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface HelpViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
@property(nonatomic , retain)NSArray *dataSourceArr ;
@property (weak, nonatomic) IBOutlet UITableView *helpTableView;
@end
