//
//  RingStyleTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AlarmInfoTableViewCell.h"
#import "ListViewController.h"
#import "MusicModel.h"

@implementation AlarmInfoTableViewCell

- (void)awakeFromNib
{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    self.styleView.height = 30 ;
    _styleView.clipsToBounds = YES ;
    _RingStyleTitleStr = @"音乐" ;
    MusicModel *musicModel = _listTitleArr[0];
    _showTitle.text = musicModel.musicName;
}
#pragma mark----响铃方式（音乐、语音、FM）
- (IBAction)selectRingStyleAction:(UIButton*)sender
{
  
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
    //更换标题
    _RingStyleTitleStr = [sender titleForState:UIControlStateNormal];
    NSString *changeTitle = [_showButton titleForState:UIControlStateNormal];
    [_showButton setTitle:_RingStyleTitleStr forState:UIControlStateNormal];
    [sender setTitle:changeTitle forState:UIControlStateNormal];
    
    _isOpenRingType = !_isOpenRingType ;
    
    //kvo 来监听响铃方式改变时对应列表也跟着变
    [self titleCorrespondList:_RingStyleTitleStr];

}
#pragma mark----闹钟音量是否渐渐加大
- (IBAction)ringSoundButtonActin:(UIButton *)sender
{
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
    if (_sound.length == 0) {
        _sound = @"5" ;
    }
    static int vol_type = 0 ;          //铃音类型0 为语音;1 为音乐;2 为 FM;3 为系统
    if ([_RingStyleTitleStr isEqualToString:@"语音"]) {
        vol_type = 0 ;
    }else if ([_RingStyleTitleStr isEqualToString:@"音乐"]){
        vol_type = 1 ;
    }else if ([_RingStyleTitleStr isEqualToString:@"FM"]){
        vol_type = 2 ;
    }else{
        vol_type = 3 ;
    }
    // @"file_path":@"0",   音源路径    @"file_id" : @"8"           音源 ID
    NSString *file_path =[NSString new];
    NSString *file_id = [NSString new];
    if ([MusicModel sharedManager].musicUrl.length != 0) {
        
        file_path = [MusicModel sharedManager].musicUrl ;
        file_id = [MusicModel sharedManager].musicId ;

   }
    //频率、音量 、铃音类型 、音源路径 、音源 ID
    NSArray * infoArr = @[ [NSNumber numberWithInt:_repeatDates] , _sound , [NSNumber numberWithInt:vol_type] , file_path , file_id];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlarmInfo" object:infoArr];
    
}
#pragma mark----设置重复的日期
- (IBAction)setRepeatDate:(UIButton*)sender
{
    NSArray *frequencyArr = @[@"64" , @"1" , @"2" ,@"4" , @"8" , @"16" , @"32"];
    NSString *strInt = frequencyArr[sender.tag];
    sender.selected = !sender.selected ;
    if (sender.selected) {
         [sender setBackgroundImage:[self imageWithColor:buttonBackgundColor] forState:UIControlStateSelected];
         _repeatDates = _repeatDates + strInt.intValue;
    }else{
        _repeatDates = _repeatDates - strInt.intValue;
    }
     
}

#pragma mark----ring列表
- (IBAction)pushRingList:(id)sender
{
    static  ListViewController *listViewCtl = nil ;
    if (listViewCtl == nil) {
        listViewCtl = [[ListViewController alloc]init];
    }
    listViewCtl.titleLabel.text = [NSString stringWithFormat:@"%@列表", _RingStyleTitleStr] ;
    [listViewCtl.titleLabel sizeToFit];
    
    if ([_RingStyleTitleStr isEqualToString:@"音乐"])  {
        listViewCtl.listArr =_listTitleArr[0];
    }
    [_pushViewCtl.navigationController pushViewController:listViewCtl animated:YES];
}
#pragma mark----重复－－点击时的背景色
-(UIImage *)imageWithColor:(UIColor *)color
{
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
    NSString *showStr ;
    if ([title isEqualToString:@"音乐"]) {
        showStr = _listTitleArr[0];
    }else if ([title isEqualToString:@"广播"]){
        showStr = _listTitleArr[0];;
    }else if ([title isEqualToString:@"语音"]){
        showStr = _listTitleArr[0];
    }
    
    _showTitle.text = showStr ;
    
}
@end
