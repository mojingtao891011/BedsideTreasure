//
//  UserInfoModel.m
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

- (void)setAttributes:(NSDictionary *)dataDic
{
    [super setAttributes:dataDic];
    
    NSDictionary *baseInfodict = dataDic[@"detail"][@"base_info"];
    self.city = baseInfodict[@"city"];
    self.pic_id = baseInfodict[@"pic_id"];
    self.pic_url = baseInfodict[@"pic_url"];
    self.sex = baseInfodict[@"sex"];
    
    NSDictionary *accountInfoDict = baseInfodict[@"acc_info"];
    self.email = accountInfoDict[@"email"];
    self.name = accountInfoDict[@"name"];
    self.phone_no = accountInfoDict[@"phone_no"];
    self.uid = accountInfoDict[@"uid"];
    
    NSArray *birthdayInfoArr = dataDic[@"detail"][@"birthday"];
    self.year = birthdayInfoArr[0];
    self.month = birthdayInfoArr[1];
    self.date = birthdayInfoArr[2];
    
}
@end
