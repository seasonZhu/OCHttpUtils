//
//  ViewController.m
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

#import "ViewController.h"
#import "CallbackApdater.h"
#import "HttpUtils.h"
#import "Model.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CallbackApdater *callbackApdater = [CallbackApdater new];
    
    callbackApdater.handle = ^(id value, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        Model *model = (Model *)value;
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"model: %@", model);
    };
    
    callbackApdater.exception = ^(NSError *error, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"error: %@", error);
    };
    
    [HttpUtils postURL:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters: nil responseClass: [Model class] callbackApdater:callbackApdater];
}


@end
