//
//  ZDViewController.m
//  OCHttpUtils
//
//  Created by seasonZhu on 07/06/2020.
//  Copyright (c) 2020 seasonZhu. All rights reserved.
//

#import "ZDViewController.h"

#import <OCHttpUtils/OCHttpUtils.h>

#import "Model.h"

@interface ZDViewController ()

@end

@implementation ZDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self normalRequest];
    [self genericRequest];
}

- (void)normalRequest {
    CallbackApdater *callbackApdater = [CallbackApdater new];
    
    callbackApdater.handle = ^(id value, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        Model *model = value;
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"model: %@", model);
    };
    
    callbackApdater.exception = ^(NSError *error, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"error: %@", error);
    };
    
    [HttpUtils postURL:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters: nil headers: nil responseClass: [Model class] callbackApdater:callbackApdater];
}


- (void)genericRequest {
    CallbackApdater *callbackApdater = [CallbackApdater new];
    
    callbackApdater.handle = ^(id value, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        BaseResponse<ListItem *> *response = value;
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"model: %@", response);
    };
    
    callbackApdater.exception = ^(NSError *error, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"error: %@", error);
    };
    
    [HttpUtils postURL:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters: nil headers: nil responseClass: [BaseResponse<ListItem *> class] callbackApdater:callbackApdater];
}
@end
