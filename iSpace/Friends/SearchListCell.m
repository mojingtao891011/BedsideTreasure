//
//  SearchListCell.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-26.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "SearchListCell.h"
#import "UIImageView+WebCache.h"

@implementation SearchListCell

- (void)awakeFromNib
{
    self.addButton.layer.borderWidth = 1.0 ;
    self.addButton.layer.borderColor =  [UIColor colorWithRed:125/255.0 green:214/255.9 blue:208/255.0 alpha:1.0].CGColor ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
- (void)layoutSubviews
{
    [self.friendsImg setImageWithURL:[NSURL URLWithString:_friendsInfoModel.pic_url] placeholderImage:[UIImage imageNamed:@"ic_test_head"]];
    
    self.friendsName.text = _friendsInfoModel.name ;
    [self.friendsName sizeToFit];
    
    if ([_friendsInfoModel.sex intValue] == 0) {
        self.friendsSex.text = @"女" ;
    }else if([_friendsInfoModel.sex intValue] == 1){
         self.friendsSex.text = @"男" ;
    }
    [self.friendsSex sizeToFit];
    
    self.friendsCity.text = _friendsInfoModel.city ;
    [self.friendsCity sizeToFit];
}
- (IBAction)addFriendsAction:(id)sender {
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"验证申请" message:@"您需要发送验证请求，并在对方通过后才能成为好友" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", @"确定", nil];
    alerView.alertViewStyle  = UIAlertViewStylePlainTextInput;
    [alerView show];
}
#pragma mark-----UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   
    if (buttonIndex == 0) {
        return ;
    }
    //添加好友
    NSString *explain = [alertView textFieldAtIndex:0].text;
    NSMutableDictionary *dict = [NetDataService needCommand:@"2069" andNeedUserId:USER_ID AndNeedBobyArrKey:@[@"account" , @"explain"] andNeedBobyArrValue:@[_friendsInfoModel.name , explain]];
    [NetDataService requestWithUrl:URl dictParams:dict httpMethod:@"POST" AndisWaitActivity:YES AndWaitActivityTitle:nil andViewCtl:_showAlerViewCtl completeBlock:^(id result){
    
        int errorInt = [result[@"message_body"][@"error"] intValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self returnMainView:errorInt];
        });
        
    }];
  
}
#pragma mark-----返回到主界面刷UI
- (void)returnMainView:(int)errorInt
{
  //  1:已经是你的好友了,禁止重复添加 0:消息已发送,等待用户确认。 -200:用户未注册 -213:系统禁止添加自己
    NSString *messages = nil ;
    if (errorInt == 1) {
        messages = @"已经是你的好友了,禁止重复添加";
    }else if (errorInt == 0){
        messages = @"消息已发送,等待用户确认";
    }else if (errorInt == -200){
        messages = @"用户未注册";
    }else if (errorInt == -213){
        messages = @"系统禁止添加自己";
    }
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"友情提示" message:messages delegate:self cancelButtonTitle:nil otherButtonTitles: @"确定", nil];
    [alerView show];

}
@end
