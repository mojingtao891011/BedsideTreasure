//
//  AddLocalMusicViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-5-9.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AddLocalMusicViewController.h"

@interface AddLocalMusicViewController ()

@end

@implementation AddLocalMusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _imgName = @"bt_radio_normal" ;
    [self setExtraCellLineHidden:_musicListTableView];
    [self _initPlayer];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1 ;
    }
    return _myCollection.items.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    
        static NSString *cellId = @"cellID" ;
        UITableViewCell *addMusicCell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (addMusicCell == nil) {
                addMusicCell = [[NSBundle mainBundle]loadNibNamed:@"ListCell" owner:self options:nil][0];
            }
        UIImageView *radioImg = (UIImageView*)[addMusicCell.contentView viewWithTag:1];
        UILabel *musicName = (UILabel*)[addMusicCell.contentView viewWithTag:2];
        UIImageView *clockImg = (UIImageView*)[addMusicCell.contentView viewWithTag:3];
        if (indexPath.row == _selectedRow) {
            [radioImg setImage:[UIImage imageNamed:_imgName]];
            clockImg.hidden =  !_isHidden;
        }else{
            [radioImg setImage:[UIImage imageNamed:@"bt_radio_normal"]];
            clockImg.hidden = YES ;
        }
        MPMediaItem *musicItems = _myCollection.items[indexPath.row];
        musicName.text = [musicItems valueForProperty:MPMediaItemPropertyTitle];
        return addMusicCell ;
    }
    else if (indexPath.section == 1){
        UITableViewCell *addButtonCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [addButton setTitle:@"addmusic" forState:UIControlStateNormal];
        [addButton setTitleColor:buttonBackgundColor forState:UIControlStateNormal];
        [addButton setFrame:CGRectMake(120, 20, 80, 20)];
        [addButton addTarget:self action:@selector(addMusicAction:) forControlEvents:UIControlEventTouchUpInside];
        [addButtonCell.contentView addSubview:addButton];
        return addButtonCell ;
    }
    return nil ;
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return ;
    }
    MPMediaItem *item = [[_myCollection items] objectAtIndex:indexPath.row];
    [_player setNowPlayingItem:item];
   
    static BOOL isplay = YES ;
    if (_selectedRow == 0 && _selectedRow == indexPath.row) {
        static int count = 0 ;
        if (count % 2 == 0) {
             [_player play];
        }else{
            [_player pause];
        }
        count++ ;
    }
    else if (_selectedRow != indexPath.row) {
        isplay = NO ;
        [_player play];
    }else{
        if (isplay) {
            [_player play];
        }else{
            [_player pause];
        }
        isplay = !isplay ;
        
    }
    _selectedRow = indexPath.row , _imgName = @"bt_radio_pressed" ;
    _isHidden = YES;
    [_musicListTableView reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 60 ;
    }else
        return 44 ;

}
#pragma mark-----添加音乐按钮
- (void)addMusicAction:(UIButton*)sender
{
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self ;
    mediaPicker.allowsPickingMultipleItems = YES ;
    mediaPicker.prompt = @"AddMusic";
    [self presentViewController:mediaPicker animated:YES completion:NULL];
}
#pragma mark------MPMediaPickerControllerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (_myCollection == nil) {
        _myCollection = mediaItemCollection ;
        [_player setQueueWithItemCollection:_myCollection];
        [_musicListTableView reloadData];
        
    }else{
        NSArray *oldItems = [_myCollection items];
        NSArray *newItems = [oldItems arrayByAddingObjectsFromArray:[mediaItemCollection items]];
         NSArray *mergerItems = [oldItems arrayByAddingObjectsFromArray:newItems];
        _myCollection = [[MPMediaItemCollection alloc]initWithItems:mergerItems];
        [_musicListTableView reloadData];
    }
    for (MPMediaItem *item in _listArr) {
        NSNumber *p_Id = [item valueForProperty:MPMediaEntityPropertyPersistentID];
        NSString *name = [item valueForProperty:MPMediaItemPropertyTitle];
        NSLog(@"%@----%@" , p_Id , name);
    }
    
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
