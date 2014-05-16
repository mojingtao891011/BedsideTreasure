//
//  WifiViewController.m
//  InAppWebHTTPServer
//
//  Created by bear on 14-5-15.
//  Copyright (c) 2014年 AlimysoYang. All rights reserved.
//

#import "WifiViewController.h"
#import "HTTPServer.h"
#import "AYHTTPConnection.h"
#import "MultipartMessageHeader.h"
#import "NSString+URLEncoding.h"


#define GBUnit 1073741824
#define MBUnit 1048576
#define KBUnit 1024
@interface WifiViewController ()

@end

@implementation WifiViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    currentDataLength = 0 ;
    [self _initHttpServer];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithStart:) name:UPLOADSTART object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploading:) name:UPLOADING object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithEnd:) name:UPLOADEND object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadWithDisconnect:) name:UPLOADISCONNECTED object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UPLOADSTART object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UPLOADING object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UPLOADEND object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UPLOADISCONNECTED object:nil];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)_initHttpServer
{
    _httpserver = [[HTTPServer alloc] init];
    [_httpserver setType:@"_http._tcp."];
    [_httpserver listeningPort];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"website"];
    [_httpserver setDocumentRoot:webPath];
    [_httpserver setConnectionClass:[AYHTTPConnection class]];
    [self startServer];

}
//开启HTTP服务器
- (void) startServer
{
    //Started HTTP Server\n
    NSError *error;
    if ([_httpserver start:&error])
        [_lbHTTPServer setText:[NSString stringWithFormat:@"http://%@:%hu", [_httpserver hostName], [_httpserver listeningPort]]];
    else
        NSLog(@"Error Started HTTP Server:%@", error);
}
#pragma mark-----note
//文件开始传输通知
- (void) uploadWithStart:(NSNotification *) notification
{
    UInt64 fileSize = [(NSNumber *)[notification.userInfo objectForKey:@"totalfilesize"] longLongValue];
    __block NSString *showFileSize = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (fileSize>GBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%.1fG", (CGFloat)fileSize / (CGFloat)GBUnit];
        if (fileSize>MBUnit && fileSize<=GBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%.1fMB", (CGFloat)fileSize / (CGFloat)MBUnit];
        else if (fileSize>KBUnit && fileSize<=MBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%lliKB", fileSize / KBUnit];
        else if (fileSize<=KBUnit)
            showFileSize = [[NSString alloc] initWithFormat:@"/%lliB", fileSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_lbFileSize setText:showFileSize];
            [_progressView setHidden:NO];
        });
    });
    showFileSize = nil;
}
//文件传输完成通知
- (void) uploadWithEnd:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        currentDataLength = 0;
        [_progressView setHidden:YES];
        [_progressView setProgress:0.0];
        [_lbFileSize setText:@""];
        [_lbCurrentFileSize setText:@""];
    });

}
//传输重复文件通知
- (void) uploadWithDisconnect:(NSNotification *) notification
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        currentDataLength = 0;
        [_progressView setHidden:YES];
        [_progressView setProgress:0.0];
        [_lbFileSize setText:@""];
        [_lbCurrentFileSize setText:@""];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information" message:@"Upload data interrupt!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        alert = nil;
    });
}
//文件传输状态更新通知
- (void) uploading:(NSNotification *)notification
{
    float value = [(NSNumber *)[notification.userInfo objectForKey:@"progressvalue"] floatValue];
    currentDataLength += [(NSNumber *)[notification.userInfo objectForKey:@"cureentvaluelength"] intValue];
    __block NSString *showCurrentFileSize = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        if (currentDataLength>GBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%.1fG", (CGFloat)currentDataLength / (CGFloat)GBUnit];
        if (currentDataLength>MBUnit && currentDataLength<=GBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%.1fMB", (CGFloat)currentDataLength / (CGFloat)MBUnit];
        else if (currentDataLength>KBUnit && currentDataLength<=MBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%lliKB", currentDataLength / KBUnit];
        else if (currentDataLength<=KBUnit)
            showCurrentFileSize = [[NSString alloc] initWithFormat:@"%lliB", currentDataLength];
        dispatch_async(dispatch_get_main_queue(), ^{
            _progressView.progress += value;
            [_lbCurrentFileSize setText:showCurrentFileSize];
        });
    });
    showCurrentFileSize = nil;
}
@end
