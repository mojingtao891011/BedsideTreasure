//
//  OtherDevicesCell.m
//  HOME
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "OtherDevicesCell.h"

@implementation OtherDevicesCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    self.height = 44 ;
}
- (IBAction)changeDevicesAction:(UIButton*)sender {
    sender.selected = !sender.selected ;
    
}
@end
