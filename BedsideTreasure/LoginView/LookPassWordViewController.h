//
//  LookPassWordViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface LookPassWordViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
{
    NSArray *_titleArr ;
}
@property (weak, nonatomic) IBOutlet UITableView *lookPassWordTableView;
@end
