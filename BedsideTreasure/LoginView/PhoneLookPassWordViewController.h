//
//  PhoneLookPassWordViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface PhoneLookPassWordViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *CancelButton;
- (IBAction)CancelAction:(id)sender;
- (IBAction)enterAction:(id)sender;


@end
