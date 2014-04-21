//
//  AddMusicTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-19.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface AddMusicTableViewCell : UITableViewCell<MPMediaPickerControllerDelegate>

@property(nonatomic , retain)UIViewController *present_ViewController ;

@property(nonatomic , retain)MPMediaItemCollection *myCollection ;
@property(nonatomic , retain)NSMutableArray *listArr ;

- (IBAction)addMusicAction:(id)sender;

@end
