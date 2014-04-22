//
//  OtherDevicesTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-22.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "OtherDevicesTableViewCell.h"

@implementation OtherDevicesTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)isSelectButton:(UIButton*)sender {
       
    static int index= 0 ;
    index = sender.tag - 10 ;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"POSTINDEXS" object:[NSString stringWithFormat:@"%d" , index]];
}

- (IBAction)cancelAction:(UIButton*)sender {
    
    sender.tag = 100 ;
    [self isSelectButton:sender];
}

- (IBAction)enterAction:(UIButton*)sender {
    sender.tag = 100 ;
    [self isSelectButton:sender];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addDevicesButtonAction" object:nil];
}
@end
