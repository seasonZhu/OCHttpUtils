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
    
    [HttpUtils postURL:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters: nil headers: nil responseClass: [Model class] callbackApdater:callbackApdater];
    
    //[self request];
    [self idRequet];
    [self requestAndReponse];
}

- (void)request {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            BaseResponse<ListItem *>* model = [BaseResponse<ListItem *> yy_modelWithJSON:responseObject];
            NSLog(@"model: %@", model);
            
//            ListItem *first = model.list.firstObject;
//            
//            NSLog(@"first: %@", first);
//            
//            NSString *topicDesc = first.topicDesc;
//            
//            NSLog(@"topicDesc: %@",topicDesc);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}

- (void)idRequet {
    CallbackApdater *callbackApdater = [CallbackApdater new];
    
    callbackApdater.handle = ^(id value, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        Response *response = (Response *)value;
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"response: %@", response);
        
        if (response.code == 0) {
            NSArray<ListItem *> *list = [response transformToArayyWithClass:[ListItem class]];
            
            NSLog(@"list: %@", list);
        }
    };
    
    callbackApdater.exception = ^(NSError *error, NSInteger statusCode, HttpResponseStatus httpResponseStatus) {
        NSLog(@"httpResponseStatus: %ld", (long)httpResponseStatus);
        NSLog(@"statusCode: %ld", (long)statusCode);
        NSLog(@"error: %@", error);
    };
    
    [HttpUtils postURL:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters: nil headers: nil responseClass: [Response class] callbackApdater:callbackApdater];
}

- (void)requestAndReponse {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://sun.topray-media.cn/tz_inf/api/topics" parameters:nil headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            Response* response = [Response yy_modelWithJSON:responseObject];
            NSLog(@"response: %@", response);
            
            if (response.code == 0) {
                NSArray *list = [response transformToArayyWithClass:[ListItem class]];
                
                NSLog(@"list: %@", list);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
}

@end
