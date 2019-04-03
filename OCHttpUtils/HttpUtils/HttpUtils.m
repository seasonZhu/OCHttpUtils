//
//  HttpUtils.m
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import "HttpUtils.h"
#import <AFNetworking.h>

@implementation HttpUtils

#pragma mark- 对外方法

/**
 post请求

 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)postURL:(NSString *)url
     parameters:(NSDictionary *)parameters
  responseClass:(Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self requst:url method:@"Post" parameters:(NSDictionary *)parameters responseClass:responseClass callbackApdater:callbackApdater];
}

/**
 get请求
 
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)getURL:(NSString *)url
    parameters:(NSDictionary *)parameters
 responseClass:(Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self requst:url method:@"Get" parameters:(NSDictionary *)parameters responseClass:responseClass callbackApdater:callbackApdater];
}

#pragma mark- 对内方法

/**
 请求

 @param url 网址
 @param method 请求方法 @"Post" @"Get"等
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)requst:(NSString *)url
        method:(NSString *)method
    parameters:(NSDictionary *)parameters
   responseClass:(Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater  {

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if ([method isEqualToString:@"Post"]) {
        [manager POST:url parameters:parameters progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  [self responseSuccessWithClass:responseClass sessionDataTask:task responseObject:responseObject callbackApdater:callbackApdater];
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  [self responseFailureWithTask:task error:error callbackApdater:callbackApdater];
        }];
    } else if ([method isEqualToString:@"Get"]) {
        [manager GET:url parameters:parameters progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  [self responseSuccessWithClass:responseClass sessionDataTask:task responseObject:responseObject callbackApdater:callbackApdater];
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  [self responseFailureWithTask:task error:error callbackApdater:callbackApdater];
        }];
    }
}


/**
 成功的处理

 @param responseClass 响应的模型类型
 @param task 请求任务
 @param responseObject 响应内容
 @param callbackApdater 回调
 */
+ (void)responseSuccessWithClass:(Class)responseClass
                 sessionDataTask:(NSURLSessionDataTask *)task
                  responseObject:(id)responseObject
                 callbackApdater:(id<CallbackProtocol>)callbackApdater {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = httpResponse.statusCode;
    if (statusCode == 200) {
        if ([responseClass conformsToProtocol:@protocol(YYModel)]) {
            id value = [responseClass yy_modelWithJSON: responseObject];
            [callbackApdater handleValue:value statusCode:statusCode responseStatus:ResponseSuccessAndConformYYModel];
        }else {
            [callbackApdater handleValue:responseObject statusCode:statusCode responseStatus:ResponseSuccessAndNotConformYYModel];
        }
    }else {
        [callbackApdater exception:nil statusCode:statusCode responseStatus:ResponseSuccessAndStatusCodeNot200];
    }
}

/**
 失败的处理

 @param task 请求任务
 @param error NSError
 @param callbackApdater 回调
 */
+ (void)responseFailureWithTask:(NSURLSessionDataTask *)task
                          error:(NSError *)error
                callbackApdater:(id<CallbackProtocol>)callbackApdater {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = httpResponse.statusCode;
    [callbackApdater exception:error statusCode:statusCode responseStatus:ResponseFailure];
}

@end
