//
//  RingStyleTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AlarmInfoTableViewCell.h"
#import "ListViewController.h"
#import "RecordModel.h"
#import "AddLocalMusicViewController.h"
#import "AddMusicViewController.h"

@implementation AlarmInfoTableViewCell

- (void)awakeFromNib
{
    _RingStyleTitleStr = @"音乐" ;
    
    //进音乐列表选（接收选中通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedMusicNote:) name:@"postMusicModel" object:nil];
    
    //进FM列表选（接收选中通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedFMNote:) name:@"postFMlist" object:nil];
    
    //进语音列表选（接收选中通知）
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectedRecordNote:) name:@"postRecordModel" object:nil];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.styleView.height = 30 ;
    _styleView.clipsToBounds = YES ;
    NSString *showStr =  [_showButton titleForState:UIControlStateNormal];
    [self titleCorrespondList:showStr];
   
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
        _sound = @"255" ;
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
    static int vol_type = 0 ;          //铃音类型  0 为语音;1 为音乐;2 为 FM;3 为系统
    NSArray * infoArr = nil ;        //频率、音量 、铃音类型 、FM频道 、音源路径 、音源 ID
    if ([_RingStyleTitleStr isEqualToString:@"音乐"]) {
        
        vol_type = 1 ;
         infoArr = @[ [NSNumber numberWithInt:_repeatDates] , _sound , [NSNumber numberWithInt:vol_type] ,@"-1", @"" , @"-1"];
        
    }else if ([_RingStyleTitleStr isEqualToString:@"语音"]){
        
        vol_type = 0 ;
        RecordModel *recordModel = _recordArr[0];
        NSString *file_path =recordModel.recordUrl;   //音源路径
        NSString *file_id = recordModel.recordId;        // 音源 ID
        infoArr = @[ [NSNumber numberWithInt:_repeatDates] , _sound , [NSNumber numberWithInt:vol_type] ,@"-1", file_path , file_id];
        
    }else if ([_RingStyleTitleStr isEqualToString:@"广播"]){
        
        vol_type = 2 ;
       
        NSString *fm_chnl = _FMArr[0];             //FM频道
        infoArr = @[ [NSNumber numberWithInt:_repeatDates] , _sound , [NSNumber numberWithInt:vol_type] ,fm_chnl , @"" , @"-1"];
        
    }else{
        vol_type = 3 ;
    }
    NSLog(@"infoArr = %@" , infoArr);
    [[NSNotificationCenter defaultCenter]postNotificationName:@"AlarmInfo" object:infoArr];
    
}
#pragma mark------note
 //进音乐列表选（接收选中通知）
- (void)selectedMusicNote:(NSNotification*)musicNote
{
    [[NSUserDefaults standardUserDefaults] setObject:[musicNote object] forKey:@"musicName"];
    [[NSUserDefaults standardUserDefaults]  synchronize];
    
    [self titleCorrespondList:@"音乐"];
}
- (void)selectedFMNote:(NSNotification*)FMnote
{
     [_FMArr exchangeObjectAtIndex:0 withObjectAtIndex:[[FMnote object] integerValue]];
     [self titleCorrespondList:@"广播"];
}
- (void)selectedRecordNote:(NSNotification*)Recordnote
{
    [_recordArr exchangeObjectAtIndex:0 withObjectAtIndex:[[Recordnote object] integerValue]];
    [self titleCorrespondList:@"语音"];

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
    ListViewController *listViewCtl = [[ListViewController alloc]init];
    listViewCtl.titleLabel.text = [NSString stringWithFormat:@"%@列表", _RingStyleTitleStr] ;
    [listViewCtl.titleLabel sizeToFit];
    
    static AddMusicViewController *addLocalMusicCtl = nil ;
    if ([_RingStyleTitleStr isEqualToString:@"音乐"])  {
        if (addLocalMusicCtl == nil) {
             addLocalMusicCtl = [[AddMusicViewController alloc]init];
        }
        [_pushViewCtl.navigationController pushViewController:addLocalMusicCtl animated:YES];
        return ;
    }else if ([_RingStyleTitleStr isEqualToString:@"广播"])  {
        listViewCtl.listArr =[_FMArr copy];
    }else if ([_RingStyleTitleStr isEqualToString:@"语音"])  {
        listViewCtl.listArr =[_recordArr copy];
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
   
    if ([title isEqualToString:@"音乐"]) {
        NSString *musicName = [[NSUserDefaults standardUserDefaults]objectForKey:@"musicName"] ;
        if (musicName.length == 0) {
            _showTitle.text = @"点击进入音乐列表" ;
        }else{
            _showTitle.text = musicName ;
        }
        
    }else if ([title isEqualToString:@"广播"]){
        if (_FMArr.count != 0) {
            _showTitle.text = _FMArr[0];
           
        }else{
            _showTitle.text = @"当前无FM信息" ;
        }
    }else if ([title isEqualToString:@"语音"]){
        if (_recordArr.count != 0) {
            RecordModel *recordModel = _recordArr[0];
           _showTitle.text = recordModel.recordName;
        }else
        {
            _showTitle.text = @"当前无语音信息" ;
        }
   }
    
}
@end
