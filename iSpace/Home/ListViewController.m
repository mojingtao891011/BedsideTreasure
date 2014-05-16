//
//  ListViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-14.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ListViewController.h"
#import "MusicModel.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setExtraCellLineHidden:_listTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
#pragma mark-----UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _listArr.count ;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID" ;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    if ([self.titleLabel.text isEqualToString:@"音乐列表"])
    {
         MusicModel *model = _listArr[indexPath.row];
         cell.textLabel.text =model.musicName;
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"])
    {
        
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"])
    {
        cell.textLabel.text =_listArr[indexPath.row] ;
    }
    cell.imageView.image = [UIImage imageNamed:@"bt_play"];
   
    
    return cell ;
}
#pragma mark-----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if ([self.titleLabel.text isEqualToString:@"音乐列表"]) {
        MusicModel *model = _listArr[indexPath.row];
        [MusicModel sharedManager].musicName = model.musicName ;
        [MusicModel sharedManager].musicUrl = model.musicUrl ;
        [MusicModel sharedManager].musicId = model.musicId ;
        //发送更改标题通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postTitle" object:model.musicName];
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"]) {
        
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"]) {
        
    }

}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
@end
