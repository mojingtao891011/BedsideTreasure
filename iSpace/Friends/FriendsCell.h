//
//  FriendsCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-25.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsInfoMOdel.h"

@interface FriendsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *friendsImg;
@property (weak, nonatomic) IBOutlet UILabel *friendsName;
@property (weak, nonatomic) IBOutlet UIImageView *isBindImg;
@property (weak, nonatomic) IBOutlet UILabel *friendsTitle;
@property (nonatomic , retain)FriendsInfoModel    *friendsInfoModel ;

@end
