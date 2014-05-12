//
//  ListViewController.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-14.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "ListViewController.h"
#import "RecordModel.h"

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
    
    _imgName = @"bt_radio_normal" ;
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
    UITableViewCell *listCell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (listCell == nil) {
        listCell = [[NSBundle mainBundle]loadNibNamed:@"ListCell" owner:self options:nil][0];
    }
   UIImageView *radioImg = (UIImageView*)[listCell.contentView viewWithTag:1];
   UIImageView *clockImg = (UIImageView*)[listCell.contentView viewWithTag:3];
    if (indexPath.row == _selectedRow) {
        [radioImg setImage:[UIImage imageNamed:_imgName]];
        clockImg.hidden =  !_isHidden;
    }else{
         [radioImg setImage:[UIImage imageNamed:@"bt_radio_normal"]];
        clockImg.hidden = YES ;
    }
    UILabel *nameLabel = (UILabel*)[listCell.contentView viewWithTag:2];
    
    if ([self.titleLabel.text isEqualToString:@"音乐列表"])
    {
        
        
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"])
    {
        RecordModel *model = _listArr[indexPath.row];
        nameLabel.text =model.recordName ;
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"])
    {
        nameLabel.text =_listArr[indexPath.row] ;
    }
    
    return listCell ;
}
#pragma mark-----UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedRow = indexPath.row , _imgName = @"bt_radio_pressed" ;
    _isHidden = YES;
    [_listTableView reloadData];
    
    if ([self.titleLabel.text isEqualToString:@"音乐列表"]) {
        //发送选中通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postMusicModel" object:[NSNumber numberWithInt:indexPath.row]];
    }
    else if ([self.titleLabel.text isEqualToString:@"语音列表"]) {
        //发送选中通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postRecordModel" object:[NSNumber numberWithInt:indexPath.row]];
    }
    else if ([self.titleLabel.text isEqualToString:@"广播列表"]) {
        //发送选中通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"postFMlist" object:[NSNumber numberWithInt:indexPath.row]];
    }

}
//UITableView隐藏多余的分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}
@end
