//
//  RingViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface RingViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate , MPMediaPickerControllerDelegate>

@property(nonatomic , retain)NSMutableArray *listArr ;

@property (strong, nonatomic)  UIView *headView;
@property(nonatomic , retain)NSArray *titleArr ;

@property(nonatomic , assign)BOOL headBool0 ;
@property(nonatomic , assign)BOOL headBool1 ;
@property(nonatomic , assign)BOOL headBool2 ;
@property(nonatomic , assign)BOOL headBool3 ;
@property(nonatomic , assign)int  boolInt  ;






@property (weak, nonatomic) IBOutlet UITableView *ringTabelView;

@end
