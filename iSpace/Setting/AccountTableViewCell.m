//
//  AccountTableViewCell.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AccountTableViewCell.h"


@implementation AccountTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)selectedAction:(UIButton *)sender {
    
        for (UIView *v  in self.subviews) {
        if ( [v isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton*)v ;
            button.selected = NO ;
        }
    }
    sender.selected = !sender.selected ;
   
}
@end
