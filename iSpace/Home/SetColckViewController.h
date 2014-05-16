//
//  SetColckViewControllers.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface SetColckViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
{
    NSMutableArray *_listArr ;
}
@property (weak, nonatomic) IBOutlet UITableView *setAlarmTabelView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepickView;
@property(nonatomic , assign)int clockButtonTag ;
@end
