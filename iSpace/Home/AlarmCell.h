//
//  AlarmCell.h
//  HOME
//
//  Created by 莫景涛 on 14-4-23.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Clock.h"
#import "AlarmInfoModel.h"

@interface AlarmCell : UITableViewCell

@property (weak, nonatomic) IBOutlet Clock *clock1;
@property (weak, nonatomic) IBOutlet Clock *clock2;
@property (weak, nonatomic) IBOutlet Clock *clock3;
@property (weak, nonatomic) IBOutlet Clock *clock4;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel1;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel2;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel3;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel4;
@property(retain, nonatomic)NSArray *clockArr ;
@property(retain, nonatomic)NSArray *clockLabelArr ;
@property(retain, nonatomic)NSMutableArray *alarmInfoArr ;
@property(retain, nonatomic)UIViewController *pushViewCtl ;

- (IBAction)clickClockButtonActioon:(id)sender;
@end
