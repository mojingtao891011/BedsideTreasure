//
//  HomeViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "HomeViewController.h"
#import "SetColckViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"主页" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
        
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getDatetime:) name:@"123" object:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
- (void)getDatetime:(NSNotification*)note
{
    NSDictionary *dataDict = [note object];
    NSArray *keyArr = [dataDict allKeys];
    NSDate *dictKey = keyArr[0];
    NSDate *date = dataDict[dictKey];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm:aa"];
    NSString *timeStr = [dateFormatter stringFromDate:date];
    NSInteger clockTag = [keyArr[0] integerValue];
    
    switch (clockTag) {
        case 1:
            _clock1.time = date ;
            [_clock1 setNeedsDisplay];
            _clockLabel1.text = timeStr ;
            _clockLabel1.alpha = 1.0 ;
            _clock1.alpha = 1.0 ;
            break;
        case 2:
            _clock2.time = date ;
            [_clock2 setNeedsDisplay];
            _clockLabel2.text = timeStr ;
            _clockLabel2.alpha = 1.0 ;
            _clock2.alpha = 1.0 ;
            break;
        case 3:
            _clock3.time = date ;
            [_clock3 setNeedsDisplay];
            _clockLabel3.text = timeStr ;
            _clockLabel3.alpha = 1.0 ;
            _clock3.alpha = 1.0 ;
            break;
        case 4:
            _clock4.time = date ;
            [_clock4 setNeedsDisplay];
            _clockLabel4.text = timeStr ;
            _clockLabel4.alpha = 1.0 ;
            _clock4.alpha = 1.0 ;
            break;

        default:
            break;
    }


}
- (IBAction)clickClock:(id)sender {
    
    SetColckViewController *setClockViewCtl = [[SetColckViewController alloc]init];
    Clock *clock = (Clock*)sender ;
    setClockViewCtl.clockButtonTag = clock.tag ;
    [self.navigationController pushViewController:setClockViewCtl animated:YES];
}
- (id)mutableCopy
{
    return nil;
}
@end
