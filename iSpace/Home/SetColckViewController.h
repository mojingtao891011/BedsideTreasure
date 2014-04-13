//
//  SetColckViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-4.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import "Clock.h"

@interface SetColckViewController : BaseViewController

@property(nonatomic , assign)BOOL isOpenRingType ;
@property(nonatomic , assign)NSInteger clockButtonTag ;
@property (weak, nonatomic) IBOutlet UIView *styleVIew;


@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)selectedButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *showButton;
- (IBAction)clickstyleButton:(id)sender;

- (IBAction)getDate:(id)sender;

@end
