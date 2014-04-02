//
//  ClockView.m
//  clock
//
//  Created by 莫景涛 on 14-3-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ClockView.h"

@implementation ClockView

- (id)initWithFrame:(CGRect)frame andDate:(NSDate*)time
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.calendar = [NSCalendar currentCalendar];
        self.time = time ;

    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    [self drawClockHands];
}
//画时针、分针、秒针
- (void)drawClockHands {
    
    CGContextRef theContext = UIGraphicsGetCurrentContext();
    CGPoint theCenter = [self midPoint];
    CGFloat theRadius = CGRectGetWidth(self.bounds) / 2.0 ;
    NSDateComponents *theComponents = [self.calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit fromDate:self.time];
    CGFloat theMinute = theComponents.minute * M_PI / 30.0;
    CGFloat theHour = (theComponents.hour + theComponents.minute / 60) * M_PI / 6.0;
    
    
    CGPoint thePoint = [self pointWithRadius:theRadius * 0.5 angle:theHour];
    CGContextSetRGBStrokeColor(theContext, 232/255.0, 182/255.0, 183/255.0, 0.8);
    CGContextSetLineWidth(theContext, 4.0);
    CGContextSetLineCap(theContext, kCGLineCapRound);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y );
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    
    thePoint = [self pointWithRadius:theRadius * 0.6 angle:theMinute];
    CGContextSetLineWidth(theContext, 4.0);
    CGContextMoveToPoint(theContext, theCenter.x, theCenter.y);
    CGContextAddLineToPoint(theContext, thePoint.x, thePoint.y);
    CGContextStrokePath(theContext);
    
}

- (CGPoint)midPoint {
    CGRect theBounds = self.bounds;
    return CGPointMake(CGRectGetMidX(theBounds), CGRectGetMidY(theBounds));
}

- (CGPoint)pointWithRadius:(CGFloat)inRadius angle:(CGFloat)inAngle {
    CGPoint theCenter = [self midPoint];
    return CGPointMake(theCenter.x + inRadius * sin(inAngle), theCenter.y - inRadius * cos(inAngle));
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]];
    self.calendar = [NSCalendar currentCalendar];
    self.time = [NSDate date];
}
@end
