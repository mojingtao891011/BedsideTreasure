//
//  DevicesInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-15.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import "WXBaseModel.h"

@interface DevicesInfoModel : WXBaseModel
@property(nonatomic , retain)NSString               *dev_sn ;                             //设备序列号
@property(nonatomic , assign)int                         dev_idx ;                           //设备索引号
//都是对象
//@property(nonatomic , retain)NSString               *fm_info ;                             //设备FM信息
//@property(nonatomic , retain)NSString               *alarm_info ;                             //设备闹钟信息
//@property(nonatomic , retain)NSString               *wifi_info ;                             //设备 WIFI 信息
//@property(nonatomic , retain)NSString               *bt_info ;                             //设备BT信息
@property(nonatomic , retain)NSString               *owner ;                             //管理员 ID
@property(nonatomic , assign)int               *friend ;                             //用户 ID
@end
