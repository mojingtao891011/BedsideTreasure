//
//  RingTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-16.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "DownloadTableViewCell.h"

@implementation DownloadTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)palyAction:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
}

- (IBAction)downLoadAction:(id)sender {
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
}
@end
