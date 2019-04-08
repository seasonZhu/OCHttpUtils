//
//  HttpUtils.m
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import "HttpUtils.h"
#import <AFNetworking.h>
#import <YYModel.h>

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
     parameters:(nullable NSDictionary *)parameters
  responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self requst:url method:@"Post" parameters:parameters responseClass:responseClass callbackApdater:callbackApdater];
}

/**
 get请求
 
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)getURL:(NSString *)url
    parameters:(nullable NSDictionary *)parameters
 responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self requst:url method:@"Get" parameters:parameters responseClass:responseClass callbackApdater:callbackApdater];
}

/**
 上传请求

 @param url 网址
 @param data 上传数据
 @param filename 上传的文件名 例如@"voice.mp3"
 @param mimeType 上传的类型  例如@"image/png"
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)updateURL:(NSString *)url
             data:(NSData *)data
   updateFilename:(NSString *)filename
   updateMimeType:(NSString *)mimeType
       parameters:(nullable NSDictionary *)parameters
    responseClass:(nullable Class)responseClass
  callbackApdater:(id<CallbackProtocol>)callbackApdater {
    AFHTTPSessionManager *requestManager = [AFHTTPSessionManager manager];
    requestManager.requestSerializer.timeoutInterval = 60;
    [requestManager.requestSerializer setValue:@"multipart/form-data;charset=UTF-8"forHTTPHeaderField:@"Content-Type"];
    [requestManager.requestSerializer setValue:filename forHTTPHeaderField:@"filename"];
    
    [requestManager POST:url
              parameters:parameters
constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
        /**
         *  appendPartWithFileURL   //  指定上传的文件
         *  name                    //  指定在服务器中获取对应文件或文本时的key
         *  fileName                //  指定上传文件的原始文件名
         *  mimeType                //  指定文件的MIME类型
         */
        [formData appendPartWithFileData:data name:[filename componentsSeparatedByString:@"."].firstObject fileName:filename mimeType:mimeType];
    }
                progress:^(NSProgress *progress) {
                    [callbackApdater updateProgress:progress percent:1.0 * progress.completedUnitCount/progress.totalUnitCount];
    }
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     [self updateWithClass:responseClass sessionDataTask:task responseObject:responseObject error:nil callbackApdater:callbackApdater];
                     
                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                     [self updateWithClass:responseClass sessionDataTask:task responseObject:nil error:error callbackApdater:callbackApdater];
                 }];
}

#pragma mark- 对内方法

/**
 请求

 @param url 网址
 @param method 请求方法 @"Post"和@"Get"
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)requst:(NSString *)url
        method:(NSString *)method
    parameters:(nullable NSDictionary *)parameters
 responseClass:(nullable Class)responseClass
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
+ (void)responseSuccessWithClass:(nullable Class)responseClass
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
        [callbackApdater handleValue:nil statusCode:statusCode responseStatus:ResponseSuccessAndStatusCodeNot200];
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

/**
 上传的处理

 @param responseClass 响应的模型类型
 @param task 请求任务
 @param responseObject 响应内容
 @param error 上传错误
 @param callbackApdater 回调
 */
+ (void)updateWithClass:(nullable Class)responseClass
        sessionDataTask:(NSURLSessionDataTask *)task
         responseObject:(nullable id)responseObject
                  error:(nullable NSError *)error
        callbackApdater:(id<CallbackProtocol>)callbackApdater {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = httpResponse.statusCode;
    
    if (error) {
        [callbackApdater updateResult:NO value:responseObject statusCode:statusCode responseStatus:UpdateFailure error:error];
    }else {
        if (statusCode == 200) {
            if ([responseClass conformsToProtocol:@protocol(YYModel)]) {
                id value = [responseClass yy_modelWithJSON: responseObject];
                [callbackApdater updateResult:YES value:value statusCode:statusCode responseStatus:UpdateSuccessAndConformYYModel error:error];
            }else {
                [callbackApdater updateResult:YES value:responseObject statusCode:statusCode responseStatus:UpdateSuccessAndNotConformYYModel error:error];
            }
        }else {
            [callbackApdater updateResult:NO value:responseObject statusCode:statusCode responseStatus:ResponseSuccessAndStatusCodeNot200 error:error];
        }
    }
}

@end
