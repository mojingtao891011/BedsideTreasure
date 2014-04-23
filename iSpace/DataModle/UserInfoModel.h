//
//  UserInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-17.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "WXBaseModel.h"

@interface UserInfoModel : WXBaseModel

@property(nonatomic , copy)NSString             *name ;
@property(nonatomic , copy)NSString             *email ;
@property(nonatomic , copy)NSString             *phone_no ;
@property(nonatomic , copy)NSString             *uid ;

@property(nonatomic , copy)NSString             *city ;
@property(nonatomic , copy)NSString             *pic_id ;
@property(nonatomic , copy)NSString             *pic_url ;
@property(nonatomic , copy)NSString             *sex ;

@property(nonatomic , copy)NSString             *year ;
@property(nonatomic , copy)NSString             *month ;
@property(nonatomic , copy)NSString             *date ;

@end
