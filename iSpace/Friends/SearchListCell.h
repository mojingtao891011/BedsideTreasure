//
//  SearchListCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsInfoModel.h"

@interface SearchListCell : UITableViewCell<UIAlertViewDelegate>

@property(nonatomic , retain)FriendsInfoModel   *friendsInfoModel ;
@property(nonatomic , retain)UIViewController *showAlerViewCtl ;
@property (weak, nonatomic) IBOutlet UIImageView *friendsImg;
@property (weak, nonatomic) IBOutlet UILabel *friendsName;
@property (weak, nonatomic) IBOutlet UILabel *friendsSex;
@property (weak, nonatomic) IBOutlet UILabel *friendsCity;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addFriendsAction:(id)sender;

@end
