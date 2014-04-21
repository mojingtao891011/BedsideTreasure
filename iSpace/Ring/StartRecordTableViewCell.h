//
//  StartRecordTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-20.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StartRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *recordStauts;
- (IBAction)startRecordAction:(id)sender;

@end
