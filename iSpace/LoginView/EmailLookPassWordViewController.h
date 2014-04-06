//
//  EmailLookPassWordViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-5.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface EmailLookPassWordViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *CancelButton;
- (IBAction)enterAction:(id)sender;

@end
