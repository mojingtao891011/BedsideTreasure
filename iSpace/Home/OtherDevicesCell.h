//
//  OtherDevicesCell.h
//  HOME
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherDevicesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *changeButton;

- (IBAction)changeDevicesAction:(id)sender;
@end
