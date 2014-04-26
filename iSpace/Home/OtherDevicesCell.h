//
//  OtherDevicesCell.h
//  HOME
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DevicesInfoModel.h"

@interface OtherDevicesCell : UITableViewCell

@property(nonatomic , assign)id<UIActionSheetDelegate>dele ;
@property(nonatomic , retain)UIViewController *showViewCtl ;
@property(nonatomic , retain)NSMutableArray *devicesTotalArr ;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

- (IBAction)changeDevicesAction:(id)sender;
@end
