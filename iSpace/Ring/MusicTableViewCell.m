//
//  MusicTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "MusicTableViewCell.h"

@implementation MusicTableViewCell

- (void)awakeFromNib
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)_initPlayer
{
   
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error ;
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"error");
    }
    [session setActive:YES error:&error];
    if (error) {
        NSLog(@"NO");
    }
    
    _player = [MPMusicPlayerController iPodMusicPlayer];
    [_player beginGeneratingPlaybackNotifications];
    [_player setShuffleMode:MPMusicShuffleModeOff];
    _player.repeatMode = MPMovieRepeatModeNone ;
}

- (void)layoutSubviews
{
    self.titleName.text = _titleStr ;
    
    [self.titleName sizeToFit];
    
}
- (IBAction)palyAction:(id)sender {
    
    [self _initPlayer];
    
    UIButton *button = (UIButton*)sender ;
    button.selected = !button.selected ;
    
    if (button.selected) {
        [_player play];
    }else{
        [_player pause];
    }
    
    
}
@end
