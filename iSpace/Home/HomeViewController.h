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
@property (weak, nonatomic) IBOutlet Clock *clock1;
@property (weak, nonatomic) IBOutlet Clock *clock2;
@property (weak, nonatomic) IBOutlet Clock *clock3;
@property (weak, nonatomic) IBOutlet Clock *clock4;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel1;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel2;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel3;
@property (weak, nonatomic) IBOutlet UILabel *clockLabel4;

- (IBAction)clickClock:(id)sender;
@end
