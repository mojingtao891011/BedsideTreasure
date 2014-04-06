//
//  FeedbackViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-6.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface FeedbackViewController : BaseViewController<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *feedbackTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel1;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel2;

@end
