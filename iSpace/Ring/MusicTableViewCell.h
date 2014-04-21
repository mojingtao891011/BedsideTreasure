//
//  MusicTableViewCell.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface MusicTableViewCell : UITableViewCell

@property(nonatomic , retain)NSString *titleStr ;
@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property(nonatomic , retain)MPMediaItemCollection *myCollection ;
@property(nonatomic , retain)MPMusicPlayerController *player ;
@property(nonatomic , retain)NSMutableArray *listArr ;

- (IBAction)palyAction:(id)sender;
@end
