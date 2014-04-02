//
//  RegisterViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-2.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController<UITextFieldDelegate , UITableViewDataSource , UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *registerScrollView;
@property(nonatomic , retain)UITableView *registerTableView ;
@property(nonatomic , retain)NSArray *titleArr ;

@end
