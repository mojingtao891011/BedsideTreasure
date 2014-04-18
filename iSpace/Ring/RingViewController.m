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
    [self setExtraCellLineHidden:_ringTabelView];
    [_ringTabelView registerNib:[UINib nibWithNibName:@"DownloadTableViewCell" bundle:nil] forCellReuseIdentifier:@"DownloadTableViewCell"];
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"RecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"RecordTableViewCell"];
    
    [_ringTabelView registerNib:[UINib nibWithNibName:@"MusicTableViewCell" bundle:nil ]forCellReuseIdentifier:@"MusicTableViewCell"] ;
    
     [_ringTabelView registerNib:[UINib nibWithNibName:@"FMTableViewCell" bundle:nil] forCellReuseIdentifier:@"FMTableViewCell"];
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
        return 5;
    }else if (section == 3 && _headBool3){
        return 5;
    }

    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownloadTableViewCell *downLoadCell = [tableView dequeueReusableCellWithIdentifier:@"DownloadTableViewCell"];
    RecordTableViewCell *recordCell = [tableView dequeueReusableCellWithIdentifier:@"RecordTableViewCell"];
    MusicTableViewCell *musicCell = [tableView dequeueReusableCellWithIdentifier:@"MusicTableViewCell"];
    FMTableViewCell *FMcell =[tableView dequeueReusableCellWithIdentifier:@"FMTableViewCell"];
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        return _addMusicCell ;
    }

    switch (indexPath.section) {
        case 0:
            return downLoadCell ;
            break;
        case 1:
            return recordCell ;
            break;
        case 2:
            return musicCell ;
            break;
        case 3:
            return FMcell;
            break;
        default:
            break;
    }
       return nil ;
 }
#pragma mark------UITableViewDelegate
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.width, 20)];
    //添加标题label
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 30, 20)];
    titleLabel.text = _titleArr[section];
    titleLabel.textColor = buttonBackgundColor ;
    [titleLabel sizeToFit];
    titleLabel.backgroundColor = [UIColor clearColor] ;
    [_headView addSubview:titleLabel];
    //添加展开按钮
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [showButton setFrame:CGRectMake(tableView.width - 25, 5, 12, 12)];
    [showButton setBackgroundImage:[UIImage imageNamed:@"bt_arrow_down"] forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(clickShowButton:) forControlEvents:UIControlEventTouchUpInside];
    showButton.tag = section + 10 ;
    [_headView addSubview:showButton];
//    //添加大按钮（方便点击）
//    UIButton *bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [bigButton setFrame:CGRectMake(tableView.width - 50, 0, 40, 20)];
//    [bigButton setBackgroundColor:[UIColor redColor]];
//    bigButton.tag = 10 + section ;
//    [bigButton addTarget:self action:@selector(clickShowButton:) forControlEvents:UIControlEventTouchUpInside];
//    [_headView addSubview:bigButton];
    //旋转90°
    [UIView animateWithDuration:0.5 animations:^{
        
        CGAffineTransform   oldTrans = showButton.transform ;
        CGAffineTransform   newTrans = CGAffineTransformRotate(oldTrans, _angle * M_PI / 180);
        showButton.transform = newTrans ;
        
    }];
    
    
    //添加下划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, tableView.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [_headView addSubview:lineView];
    
    _headView.backgroundColor = ViewBackgroundColor ;
    return _headView ;
}
- (void)clickShowButton:(UIButton*)sender
{
//    _angle = _angle + 180 ;
    sender.selected = !sender.selected ;
    int headIndex = sender.tag - 10 ;
    switch (headIndex) {
        case 0:
            _headBool0 = !_headBool0 ;
            break;
        case 1:
            _headBool1 = !_headBool1 ;
            break;
        case 2:
            _headBool2 = !_headBool2 ;
            break;
        case 3:
            _headBool3 = !_headBool3 ;
            break;
        default:
            break;
    }
    
    [_ringTabelView reloadSections:[NSIndexSet indexSetWithIndex:headIndex] withRowAnimation:UITableViewRowAnimationFade];
   
}
#pragma mark------添加音乐按钮
- (IBAction)addMusic:(id)sender {
    
}
@end
