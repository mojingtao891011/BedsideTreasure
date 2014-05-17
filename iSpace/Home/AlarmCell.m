//
//  AlarmCell.m
//  HOME
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AlarmCell.h"
#import "SetColckViewController.h"
#import "SetViewController.h"

@implementation AlarmCell

- (void)awakeFromNib
{
    [self putClockToArr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)putClockToArr
{
    _clockArr = @[_clock1 , _clock2 , _clock3 , _clock4];
    _clockLabelArr = @[_clockLabel1 , _clockLabel2 , _clockLabel3 , _clockLabel4] ;
}
- (void)layoutSubviews
{
    
    for (int i = 0 ; i < _alarmInfoArr.count ; i++) {
        AlarmInfoModel *alarmModel = _alarmInfoArr[i] ;
        NSString *timeStr = [NSString stringWithFormat:@"%@:%@",alarmModel.hour , alarmModel.minute];
        //把NSString转化为NSDate
        NSDate* date = [self dateFromFomate:timeStr formate:@"HH:mm"];
        
        Clock *clock = _clockArr[i];
        clock.time = date ;
        [clock setNeedsDisplay];
        
        UILabel *timeLabel = _clockLabelArr[i];
        timeLabel.text = timeStr ;
        
    }
    
}
#pragma mark------把NSString转化为NSDate
- (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSLocale* local =[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ;
    [formatter setLocale: local];
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

- (IBAction)clickClockButtonActioon:(UIButton*)sender {
//    SetColckViewController *setClockViewCtl = [[SetColckViewController alloc]init];
//    setClockViewCtl.clockButtonTag = sender.tag ;
//    [_pushViewCtl.navigationController pushViewController:setClockViewCtl animated:YES];
    SetViewController *testView = [[SetViewController alloc]init];
    [_pushViewCtl.navigationController pushViewController:testView animated:YES];
}
@end
