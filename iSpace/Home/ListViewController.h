//
//  ListViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-14.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"


@interface ListViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
{
    NSInteger  _selectedRow ;
    BOOL _isHidden ;
    NSString *_imgName ;
}
@property(nonatomic , retain)NSMutableArray *listArr ;
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
