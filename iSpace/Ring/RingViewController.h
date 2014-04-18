//
//  RingViewController.h
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "BaseViewController.h"

@interface RingViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>

@property(nonatomic , retain)UIView *headView ;
@property(nonatomic , retain)NSArray *titleArr ;

@property(nonatomic , assign)BOOL headBool0 ;
@property(nonatomic , assign)BOOL headBool1 ;
@property(nonatomic , assign)BOOL headBool2 ;
@property(nonatomic , assign)BOOL headBool3 ;
@property(nonatomic , assign)int  angle ;

@property (strong, nonatomic) IBOutlet UITableViewCell *addMusicCell;


- (IBAction)addMusic:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *ringTabelView;

@end
