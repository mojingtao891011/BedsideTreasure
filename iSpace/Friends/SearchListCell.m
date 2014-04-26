//
//  SearchListCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SearchListCell.h"
#import "UIImageView+WebCache.h"

@implementation SearchListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    [self.friendsImg setImageWithURL:[NSURL URLWithString:_friendsInfoModel.pic_url] placeholderImage:[UIImage imageNamed:@"ic_test_head"]];
    
    self.friendsName.text = _friendsInfoModel.name ;
    [self.friendsName sizeToFit];
    
    if ([_friendsInfoModel.sex intValue] == 0) {
        self.friendsSex.text = @"女" ;
    }else if([_friendsInfoModel.sex intValue] == 1){
         self.friendsSex.text = @"男" ;
    }
    [self.friendsSex sizeToFit];
    
    self.friendsCity.text = _friendsInfoModel.city ;
    [self.friendsCity sizeToFit];
}
@end
