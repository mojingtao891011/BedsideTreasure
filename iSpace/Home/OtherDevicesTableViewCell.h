//
//  OtherDevicesTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-22.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherDevicesTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *redioButton;
@property (weak, nonatomic) IBOutlet UILabel *devicesName;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;

- (IBAction)isSelectButton:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)enterAction:(id)sender;

@end
