//
//  AlarmInfo.h
//  iSpace
//
//  Created by bear on 14-5-16.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class DevicesInfo;

@interface AlarmInfo : NSManagedObject

@property (nonatomic, retain) NSString * index;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSString * sleep_times;
@property (nonatomic, retain) NSString * sleep_gap;
@property (nonatomic, retain) NSString * hour;
@property (nonatomic, retain) NSString * minute;
@property (nonatomic, retain) NSString * vol_level;
@property (nonatomic, retain) NSString * vol_type;
@property (nonatomic, retain) NSString * fm_chnl;
@property (nonatomic, retain) NSString * file_path;
@property (nonatomic, retain) NSSet *devicesInfo;
@end

@interface AlarmInfo (CoreDataGeneratedAccessors)

- (void)addDevicesInfoObject:(DevicesInfo *)value;
- (void)removeDevicesInfoObject:(DevicesInfo *)value;
- (void)addDevicesInfo:(NSSet *)values;
- (void)removeDevicesInfo:(NSSet *)values;

@end
