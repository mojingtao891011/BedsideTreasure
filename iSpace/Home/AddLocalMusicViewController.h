//
//  AddLocalMusicViewController.h
//  iSpace
//
//  Created by 莫景涛 on 14-5-9.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface AddLocalMusicViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , MPMediaPickerControllerDelegate>
{
    NSInteger  _selectedRow ;
    BOOL _isHidden ;
    NSString *_imgName ;
}
@property (weak, nonatomic) IBOutlet UITableView *musicListTableView;

@property(nonatomic , retain)MPMediaItemCollection *myCollection ;
@property(nonatomic , retain)MPMusicPlayerController *player  ;
@property(nonatomic , retain)NSMutableArray *listArr ;

@end
