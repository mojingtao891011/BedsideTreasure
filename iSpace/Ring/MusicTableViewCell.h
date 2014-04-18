//
//  MusicTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleName;

- (IBAction)palyAction:(id)sender;
@end
