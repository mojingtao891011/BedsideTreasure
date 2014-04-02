//
//  ClockView.h
//  clock
//
//  Created by 莫景涛 on 14-3-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockView : UIView
@property (nonatomic, retain) NSCalendar *calendar;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSDate *time;

- (id)initWithFrame:(CGRect)frame andDate:(NSDate*)time;

@end
