//
//  AddMusicTableViewCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-19.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "AddMusicTableViewCell.h"

@implementation AddMusicTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (IBAction)addMusicAction:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc]initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.delegate = self ;
    mediaPicker.allowsPickingMultipleItems = YES ;
    mediaPicker.prompt = @"AddMusic";
    [_present_ViewController presentViewController:mediaPicker animated:YES completion:NULL];
}
#pragma mark------MPMediaPickerControllerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    
    [self updateMusiclist:mediaItemCollection];
     [[NSNotificationCenter defaultCenter]postNotificationName:@"postListArr" object:_listArr];
    [_present_ViewController dismissViewControllerAnimated:YES completion:NULL];
   
    
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
     [[NSNotificationCenter defaultCenter]postNotificationName:@"postListArr" object:_listArr];
    [_present_ViewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark----updateMusicList
- (void)updateMusiclist:(MPMediaItemCollection*)mediaItemCollection
{
    
    if (mediaItemCollection) {
        
        if (_myCollection == nil) {
            _myCollection = mediaItemCollection ;
            
        }
        if (_listArr == nil) {
            _listArr = [[NSMutableArray alloc]initWithCapacity:10];
        }
        //两次添加时把重复添加的过滤掉
        NSMutableArray *keepObject = [NSMutableArray arrayWithArray:mediaItemCollection.items];
        NSMutableArray *removeObject = [[NSMutableArray alloc]initWithCapacity:10];
        for (MPMediaItem *itemsList1 in _listArr) {
            
            for (MPMediaItem *itemsList2 in removeObject) {
                if ([itemsList1 isEqual:itemsList2]) {
                    
                    [removeObject addObject:itemsList2];
                    
                }
            }
        }
        [keepObject removeObjectsInArray:removeObject];
        [_listArr addObjectsFromArray:keepObject] ;
    }
//    else
//    {
//        BOOL wasPlaying = NO ;
//        if (_player.playbackState == MPMusicPlaybackStatePlaying) {
//            wasPlaying = YES ;
//        }
//        
//        MPMediaItem *nowPlayingItem = _player.nowPlayingItem ;
//        NSTimeInterval currentplayTime = _player.currentPlaybackTime ;
//        
//        NSMutableArray *combinedMediaItems = [[_myCollection items] mutableCopy];
//        NSArray *newMediaItems = [mediaItemCollection items];
//        [combinedMediaItems addObjectsFromArray:newMediaItems];
//        
//        _myCollection = [MPMediaItemCollection collectionWithItems:combinedMediaItems];
//        [_player setQueueWithItemCollection:_myCollection];
//        _player.nowPlayingItem = nowPlayingItem ;
//        _player.currentPlaybackTime = currentplayTime ;
//        if (wasPlaying) {
//            [_player play];
//        }
//        _listArr = [combinedMediaItems mutableCopy];
//        
//        for (MPMediaItem *itemsList in _listArr) {
//            NSLog(@"%@" , [itemsList valueForProperty:MPMediaItemPropertyTitle]);
//        }
//}
//    [_ringTabelView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    
    
}
@end
