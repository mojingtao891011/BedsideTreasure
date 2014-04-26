//
//  FriendsCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-25.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "FriendsCell.h"
#import "UIImageView+WebCache.h"

@implementation FriendsCell

- (void)awakeFromNib
{
    [self _initSubView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)_initSubView
{
    
}
- (void)layoutSubviews
{
    _friendsImg.layer.cornerRadius = _friendsImg.width / 2 ;
    _friendsImg.layer.masksToBounds = YES ;
    
    self.friendsName.text = _friendsInfoModel.name ;
    [self.friendsName sizeToFit];
    
    [self.friendsImg setImageWithURL:[NSURL URLWithString:_friendsInfoModel.pic_url] placeholderImage:[UIImage imageNamed:@"ic_test_head"]];
    self.backgroundColor = [UIColor clearColor];
    
}
@end
