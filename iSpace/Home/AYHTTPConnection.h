//
//  AYHTTPConnection.h
//  InAppWebHTTPServer
//
//  Created by 莫景涛 on 14-5-15.
//  Copyright (c) 2014年 AlimysoYang. All rights reserved.
//

#import "HTTPConnection.h"
#import "MultipartFormDataParser.h"

@interface AYHTTPConnection : HTTPConnection<MultipartFormDataParserDelegate>
{
    BOOL isUploading;                         //Is not being performed Upload
    MultipartFormDataParser *parser;    //
    NSFileHandle *storeFile;                  //Storing uploaded files
    UInt64 uploadFileSize;                     //The total size of the uploaded file
    //mycode
    NSString *uploadFilePath ;
    NSString *myFileName ;
}

@end
