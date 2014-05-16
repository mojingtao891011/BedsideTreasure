//
//  DevicesInfo.h
//  iSpace
//
//  Created by bear on 14-5-16.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class AlarmInfo;

@interface DevicesInfo : NSManagedObject

@property (nonatomic, retain) NSString * dev_name;
@property (nonatomic, retain) NSString * dev_city;
@property (nonatomic, retain) NSString * dev_sn;
@property (nonatomic, retain) NSString * dev_online;
@property (nonatomic, retain) NSString * dev_idx;
@property (nonatomic, retain) NSString * bt_state;
@property (nonatomic, retain) AlarmInfo *alarmInfoModel;

@end
