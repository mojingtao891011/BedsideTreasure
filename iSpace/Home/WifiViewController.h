//
//  WifiViewController.h
//  InAppWebHTTPServer
//
//  Created by bear on 14-5-15.
//  Copyright (c) 2014年 AlimysoYang. All rights reserved.
//

#import "BaseViewController.h"

@class HTTPServer ;
@interface WifiViewController : BaseViewController
{
     UInt64 currentDataLength;
}
@property (strong, nonatomic) HTTPServer *httpserver;
@property (weak, nonatomic) IBOutlet UILabel *lbHTTPServer;
@property (weak, nonatomic) IBOutlet UILabel *lbFileSize;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrentFileSize;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
