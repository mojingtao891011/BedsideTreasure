//
//  StartRecordTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-20.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "StartRecordTableViewCell.h"

@implementation StartRecordTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)startRecordAction:(UIButton*)sender {
    _recordStauts.selected = !_recordStauts.selected ;
}
@end
