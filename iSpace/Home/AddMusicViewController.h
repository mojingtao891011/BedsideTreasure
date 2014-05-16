//
//  AddMusicViewController.h
//  InAppWebHTTPServer
//
//  Created by 莫景涛 on 14-5-15.
//  Copyright (c) 2014年 AlimysoYang. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AddMusicViewController : BaseViewController<UITableViewDataSource , UITableViewDelegate>
{
    AVAudioPlayer *player ;
    NSArray *listArr  ;
    NSString *document ;
}
@property (strong, nonatomic) IBOutlet UITableViewCell *wifiCell;
@property (weak, nonatomic) IBOutlet UITableView *musicTableView;

@end
