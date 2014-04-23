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

@property(nonatomic , copy)NSString *devices_sn;
@property(nonatomic , assign)NSInteger clockButtonTag ;
@property(nonatomic , retain)NSMutableArray *musicArr ;
@property(nonatomic , retain)NSMutableArray *recordArr ;
@property(nonatomic , retain)NSMutableArray *FMArr ;

@property(nonatomic , assign)BOOL isOpenRingType ;
@property (weak, nonatomic) IBOutlet UIView *styleVIew;


@property (weak, nonatomic) IBOutlet UIDatePicker *dataPicker;
@property (weak, nonatomic) IBOutlet UIView *repeatView;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

- (IBAction)selectedButton:(id)sender;
- (IBAction)clickstyleButton:(id)sender;
- (IBAction)getDate:(id)sender;
- (IBAction)repeatAction:(id)sender;
- (IBAction)listActin:(id)sender;


@end
