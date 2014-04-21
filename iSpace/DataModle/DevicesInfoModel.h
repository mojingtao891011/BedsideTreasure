//
//  DevicesInfoModel.h
//  iSpace
//
//  Created by 莫景涛 on 14-4-15.
//  Copyright (c) 2014年 莫景涛. All rights reserved.
//
/*
"alarm_info" =     {
    list =         (
                    {
                        "file_path" = "";
                        "fm_chnl" = 0;
                        frequency = 0;
                        hour = 0;
                        index = 15;
                        minute = 0;
                        "sleep_gap" = 0;
                        "sleep_times" = 0;
                        state = 1;
                        "vol_level" = 0;
                        "vol_type" = 0;
                    }
                    );
    total = 1;
};
"dev_idx" = 15;
"dev_online" = 1;
"dev_sn" = dev100013;
*/
#import "WXBaseModel.h"
#import "AlarmInfoModel.h"

@interface DevicesInfoModel : WXBaseModel
@property (nonatomic , assign)int                           dev_idx;
@property (nonatomic , assign)int                           dev_online;
@property (nonatomic , assign)int                           dev_sn;
@property (nonatomic , retain)AlarmInfoModel    *alermInfo;
@end
