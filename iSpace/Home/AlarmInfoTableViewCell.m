//
//  RingStyleTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AlarmInfoTableViewCell.h"
#import "ListViewController.h"

@implementation AlarmInfoTableViewCell

- (void)awakeFromNib
{
    self.styleView.height = 30 ;
    _styleView.clipsToBounds = YES ;
    _sound = @"5" ;
    _titleStr = @"音乐" ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark----响铃方式（音乐、语音、FM）
- (IBAction)selectRingStyleAction:(UIButton*)sender {
  
    if (!_isOpenRingType) {
        [UIView animateWithDuration:0.5 animations:^{
            _styleView.height = 90 ;
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _styleView.height = 30 ;
        }];
    }
    if (sender.tag == 1) {
        _isOpenRingType = !_isOpenRingType ;
        return ;
    }
    
    _titleStr = [sender titleForState:UIControlStateNormal];
    NSString *changeTitle = [_showButton titleForState:UIControlStateNormal];
    [_showButton setTitle:_titleStr forState:UIControlStateNormal];
    [sender setTitle:changeTitle forState:UIControlStateNormal];
    _isOpenRingType = !_isOpenRingType ;
    
    //kvo 来监听响铃方式改变时对应列表也跟着变
    [self titleCorrespondList:_titleStr];

}
#pragma mark----闹钟音量是否渐渐加大
- (IBAction)ringSoundButtonActin:(UIButton *)sender {
    sender.selected = !sender.selected ;
    if (sender.selected) {
        _sound = @"0xFF" ;
    }else{
        _sound = @"5" ;
    }
}
#pragma mark----点确定按钮
- (IBAction)saveAlarmSetInfoAction:(id)sender
{
    NSArray * infoArr = @[@"1", @"1" , _sound ];
    NSMutableArray * mutableInfoArr = [NSMutableArray arrayWithArray:infoArr];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlarmInfo" object:mutableInfoArr];
    
}
#pragma mark----设置重复的日期
- (IBAction)setRepeatDate:(UIButton*)sender
{
    sender.selected = !sender.selected ;
    if (sender.selected) {
         [sender setBackgroundImage:[self imageWithColor:buttonBackgundColor] forState:UIControlStateSelected];
    }
    
}
#pragma mark----ring列表
- (IBAction)pushRingList:(id)sender
{
    ListViewController *listViewCtl = [[ListViewController alloc]init];
    listViewCtl.titleLabel.text = [NSString stringWithFormat:@"%@列表", _titleStr] ;
    [listViewCtl.titleLabel sizeToFit];
    [_pushViewCtl.navigationController pushViewController:listViewCtl animated:YES];
}
#pragma mark----重复－－点击时的背景色
-(UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
#pragma mark----根据响铃方式标题对应相应列表
- (void)titleCorrespondList:(NSString*)title
{
    NSMutableArray *musicArr = [NSMutableArray arrayWithObjects:@"江南stlye", nil] ;
    NSMutableArray *recordArr = [NSMutableArray arrayWithObjects:@"20140415", nil];
    NSMutableArray *FMArr = [NSMutableArray arrayWithObjects:@"深圳交通", nil];
    NSString *showStr ;
    if ([title isEqualToString:@"音乐"]) {
        showStr = musicArr[0];
    }else if ([title isEqualToString:@"广播"]){
        showStr = FMArr[0];
    }else if ([title isEqualToString:@"语音"]){
        showStr = recordArr[0];
    }
    
    _showTitle.text = showStr ;
    
}
@end
