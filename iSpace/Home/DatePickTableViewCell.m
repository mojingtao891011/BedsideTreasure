//
//  DatePickTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "DatePickTableViewCell.h"

@implementation DatePickTableViewCell

- (void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getNote:) name:@"AlarmInfo" object:nil];
}
- (void)layoutSubviews
{
    self.height = 180 ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)getNote:(NSNotification*)note
{
    
    NSMutableArray *infoArr = [note object];
    [infoArr addObject:[self stringFromFomate:_dataPickView.date formate:@"HH:mm"]];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postAlarmInfo" object:infoArr];
}
- (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	return str;
}

@end
