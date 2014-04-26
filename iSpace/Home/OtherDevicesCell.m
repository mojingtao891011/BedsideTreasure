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
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"可切换的设备" delegate:_dele cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    for (int i= 1 ; i < _devicesTotalArr.count ; i++) {
        DevicesInfoModel *model = _devicesTotalArr[i];
        [actionSheet addButtonWithTitle:model.dev_name];
    }
    [actionSheet showInView:_showViewCtl.view];

}
@end
