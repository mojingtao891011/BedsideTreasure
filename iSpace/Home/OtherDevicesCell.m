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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    self.height = 44 ;
}

- (IBAction)changeDevicesAction:(UIButton*)sender {
    sender.selected = !sender.selected ;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postNote" object:sender];
    }
- (void)layoutSubviews
{
    self.height = 44 ;
}
- (IBAction)changeDevicesAction:(UIButton*)sender {
    sender.selected = !sender.selected ;
    
}
>>>>>>> FETCH_HEAD
@end
