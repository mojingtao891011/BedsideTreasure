//
//  HomecViewController.h
//  Home
//
//  Created by bear on 14-5-11.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import "AlarmClock.h"

@interface HomeViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , UIActionSheetDelegate>

@property(nonatomic , retain)NSArray *cellArr ;
@property(nonatomic , retain)NSMutableArray *devicesTotalArr ;
@property(retain, nonatomic)NSArray *clockArr ;
@property(retain, nonatomic)NSArray *clockLabelArr ;
@property(retain , nonatomic)NSMutableArray *alarmInfoArr ;
@property(nonatomic , copy)NSString *devicesCity ;

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *iSpaceNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *iSpaceWeathCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *iSpaceClockCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *iSpaceOtherCell;
@property (weak, nonatomic) IBOutlet AlarmClock *clock1;
@property (weak, nonatomic) IBOutlet AlarmClock *clock2;
@property (weak, nonatomic) IBOutlet AlarmClock *clock3;
@property (weak, nonatomic) IBOutlet AlarmClock *clock4;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;

@property (weak, nonatomic) IBOutlet UILabel *devicesCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *TemperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *weatherStatus;
@property (weak, nonatomic) IBOutlet UILabel *AverageTemp;

- (IBAction)clickAlarmClockAction:(UIButton *)sender;

- (IBAction)changeDevicesAction:(UIButton *)sender;
@end
