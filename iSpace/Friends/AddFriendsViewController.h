//
//  AddFriendsViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface AddFriendsViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *searchListTableView;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *friendsName;
@property (nonatomic , retain)NSMutableArray *friendsArr ;

- (IBAction)searFriendsAction:(id)sender;
@end
