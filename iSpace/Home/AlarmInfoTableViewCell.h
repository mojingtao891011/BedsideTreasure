//
//  RingStyleTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-24.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *styleView;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property(nonatomic , assign)BOOL isOpenRingType ;
@property(nonatomic , copy)NSString *sound ;
@property(nonatomic , retain)UIViewController *pushViewCtl ;
@property(nonatomic , copy)NSString *RingStyleTitleStr ;
@property(nonatomic , assign)int repeatDates ;

@property(nonatomic , retain)NSMutableArray *musicArr ;
@property(nonatomic , retain)NSMutableArray *FMArr ;
@property(nonatomic , retain)NSMutableArray *recordArr ;


- (IBAction)selectRingStyleAction:(id)sender;
- (IBAction)ringSoundButtonActin:(UIButton *)sender;
- (IBAction)saveAlarmSetInfoAction:(id)sender;
- (IBAction)setRepeatDate:(id)sender;
- (IBAction)pushRingList:(id)sender;
@end
