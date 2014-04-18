//
//  RingTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-16.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *palyButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;

- (IBAction)palyAction:(id)sender;
- (IBAction)downLoadAction:(id)sender;
@end
