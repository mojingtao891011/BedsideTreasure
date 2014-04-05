//
//  HomeViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"


@interface HomeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *clockView_bg;
- (IBAction)setClockTime:(id)sender;
@end
