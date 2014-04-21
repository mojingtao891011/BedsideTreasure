//
//  HomeViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import "Clock.h"

@interface HomeViewController : BaseViewController

@property(nonatomic , retain)NSMutableArray *dev_snArr ;
@property (weak, nonatomic) IBOutlet UIScrollView *bobyView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIView *middleView;

@property (weak, nonatomic) IBOutlet UIView *endView;
@property (weak, nonatomic) IBOutlet Clock *clock1;
@property (weak, nonatomic) IBOutlet Clock *clock2;
@property (weak, nonatomic) IBOutlet Clock *clock3;
@property (weak, nonatomic) IBOutlet Clock *clock4;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel1;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel2;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel3;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel4;

@property (strong, nonatomic) IBOutlet UIView *otheriSpace;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

- (IBAction)clickClock:(id)sender;
- (IBAction)addOtheriSpace:(id)sender;
@end
