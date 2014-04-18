//
//  UserInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "WXBaseModel.h"

@interface UserInfoModel : WXBaseModel

@property(nonatomic , copy)NSString *name ;
@property(nonatomic , copy)NSString *email ;
@property(nonatomic , copy)NSString *phone_no ;

@end
