//
//  DevicesInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-15.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//
#import "WXBaseModel.h"
#import "AlarmInfoModel.h"
#import "FriendInfoModel.h"

@interface DevicesInfoModel : WXBaseModel
@property (nonatomic , copy)NSString                    * dev_idx;      //设备索引号
@property (nonatomic , copy)NSString                    *dev_online;    //设备在线状态
@property (nonatomic , copy)NSString                    *dev_sn;        //设备序列号
@property (nonatomic , copy)NSString                    *dev_city;      //设备所在城市
@property (nonatomic , copy)NSString                    *dev_name;  //设备名字
@property (nonatomic , copy)NSString                    *bt_state ;      //BT状态
@property (nonatomic , retain)NSMutableArray      *fm_list;  //设备FM信息
@property (nonatomic , retain)AlarmInfoModel      *alermInfo;             //设备闹钟信息
@property(nonatomic , retain)NSMutableArray      *alermInfoArr;       //这个设备设置了几个闹钟
@property(nonatomic , retain)FriendInfoModel          *owerInfo;          //管理员信息
@property(nonatomic , retain)FriendInfoModel         *friendInfo ;       //密友信息

@end
