//
//  RingViewController.m
//  BedsideTreasure
//
//  Created by 莫景涛 on 14-4-1.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "RingViewController.h"
#import "DownloadTableViewCell.h"
#import "RecordTableViewCell.h"
#import "MusicTableViewCell.h"
#import "FMTableViewCell.h"
#import "StartRecordTableViewCell.h"
#import "AddMusicTableViewCell.h"

@interface RingViewController ()<NSURLConnectionDelegate>
{
    NSMutableData *datas ;
}
@end

@implementation RingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.titleLabel.text = @"铃声" ;
        [self.titleLabel sizeToFit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _titleArr = @[@"在线下载" , @"语音" ,@"音乐" , @"FM"];
    _headBool2 = YES ;
    _boolInt = 0 ;
    [self registerCell];
    
    _listArr = [[NSMutableArray alloc]initWithCapacity:10] ;
        
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveNote:) name:@"postListArr" object:nil];
  
}
- (void)registerCell
{
    //隐藏多余的下划线
    [self setExtraCellLineHidden:_ringTabelView];

     [_ringTabelView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"DownloadTableViewCell"];
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordTableViewCell"];
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil ]forCellReuseIdentifier:@"MusicTableViewCell"] ;
    
     [_ringTabelView registerNib:[UINib nibWithNibName:@"FMTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMTableViewCell"];
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"StartRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"StartRecordTableViewCell"] ;
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"AddMusicTableViewCell" bundle:nil] forCellReuseIdentifier:@"AddMusicTableViewCell"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
#pragma mark------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && _headBool0) {
        return 5 ;
    }else if (section == 1 && _headBool1){
        return 5;
    }else if (section == 2 && _headBool2){
        return _listArr.count+1;
    }else if (section == 3 && _headBool3){
        return 5;
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 0) {
        StartRecordTableViewCell *startRecordCell = [tableView dequeueReusableCellWithIdentifier:@"StartRecordTableViewCell"] ;
        return startRecordCell ;
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        AddMusicTableViewCell *addMusicCell = [tableView dequeueReusableCellWithIdentifier:@"AddMusicTableViewCell"] ;
        addMusicCell.present_ViewController = self ;
        return addMusicCell ;
    }
    
    DownloadTableViewCell *downLoadCell = [tableView dequeueReusableCellWithIdentifier:@"DownloadTableViewCell"];
     RecordTableViewCell *recordCell = [tableView dequeueReusableCellWithIdentifier:@"RecordTableViewCell"];
    MusicTableViewCell *musicCell = [tableView dequeueReusableCellWithIdentifier:@"MusicTableViewCell"];
    FMTableViewCell *FMcell =[tableView dequeueReusableCellWithIdentifier:@"FMTableViewCell"];
    NSArray *arrCell = @[downLoadCell , recordCell , musicCell , FMcell];
     if (indexPath.section == 2) {
        MPMediaItem *musicObject = _listArr[indexPath.row-1] ;
        musicCell.titleStr = [musicObject valueForProperty:MPMediaItemPropertyTitle ];
    }
    return arrCell[indexPath.section];
    
    
 }
#pragma mark------UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 44)];
    _headView.tag = section + 1 ;
    //添加标题label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 30, 20)];
    titleLabel.text = _titleArr[section];
    titleLabel.textColor = buttonBackgundColor ;
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor] ;
    [_headView addSubview:titleLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickHeader:)];
    [_headView addGestureRecognizer:tap];
    
    //添加展开按钮
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showButton setFrame:CGRectMake(tableView.width - 22, 16, 12, 12)];
    [showButton setBackgroundImage:[UIImage imageNamed:@"bt_arrow_down"] forState:UIControlStateNormal];
    [_headView addSubview:showButton];
    
    //添加下划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 43, tableView.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.5 ;
    [_headView addSubview:lineView];
    
    _headView.backgroundColor = ViewBackgroundColor;
    
    NSArray *boolArr = @[[NSNumber numberWithBool:_headBool0] , [NSNumber numberWithBool:_headBool1] , [NSNumber numberWithBool:_headBool2] , [NSNumber numberWithBool:_headBool3]];
    if ([boolArr[_boolInt] boolValue]) {
        
        CGAffineTransform oldTrans = showButton.transform ;
        
        [UIView animateWithDuration:0.5 animations:^{
            CGAffineTransform newTrans = CGAffineTransformRotate(oldTrans, 180*M_PI/180);
            showButton.transform = newTrans ;
        }];
    }

        return _headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54 ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44 ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"%d" , indexPath.section);
}
#pragma mark-----customAction
#pragma mark-----点击展开按钮时
- (void)clickHeader:(UITapGestureRecognizer*)tap
{
    int headIndex = tap.view.tag;
    switch (headIndex) {
        case 1:
            _headBool0 = !_headBool0 ;
            break;
        case 2:
            _headBool1 = !_headBool1 ;
            break;
        case 3:
            _headBool2 = !_headBool2 ;
            break;
        case 4:
            _headBool3 = !_headBool3 ;
            break;
        default:
            break;
    }
    _boolInt = headIndex - 1 ;
    [_ringTabelView reloadSections:[NSIndexSet indexSetWithIndex:headIndex-1] withRowAnimation:UITableViewRowAnimationFade];

}
#pragma mark-----接收通知
- (void)receiveNote:(NSNotification*)note
{
    id result = [note object];
   _listArr = [result mutableCopy];
    
    [_ringTabelView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    
}
@end
