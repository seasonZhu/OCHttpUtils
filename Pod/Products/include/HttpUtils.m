//
//  HttpUtils.m
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import "HttpUtils.h"
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "AFHTTPSessionManager+Config.h"

@implementation HttpUtils

#pragma mark- 对外方法
+ (void)postURL:(NSString *)url
     parameters:(nullable NSDictionary *)parameters
        headers:(nullable NSDictionary<NSString *,NSString *> *)headers
  responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self request:url method:@"Post" parameters:parameters headers: headers responseClass:responseClass callbackApdater:callbackApdater];
}

+ (void)getURL:(NSString *)url
    parameters:(nullable NSDictionary *)parameters
    headers:(nullable NSDictionary<NSString *,NSString *> *)headers
 responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self request:url method:@"Get" parameters:parameters headers: headers responseClass:responseClass callbackApdater:callbackApdater];
}

+ (void)sessionManager:(AFHTTPSessionManager *)manager
               postURL:(NSString *)url
            parameters:(nullable NSDictionary *)parameters
            headers:(nullable NSDictionary<NSString *,NSString *> *)headers
         responseClass:(nullable Class)responseClass
       callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self sessionManager:manager request:url method:@"Post" parameters:parameters headers: headers responseClass:responseClass callbackApdater:callbackApdater];
}

+ (void)sessionManager:(AFHTTPSessionManager *)manager
                getURL:(NSString *)url
            parameters:(nullable NSDictionary *)parameters
            headers:(nullable NSDictionary<NSString *,NSString *> *)headers
         responseClass:(nullable Class)responseClass
       callbackApdater:(id<CallbackProtocol>)callbackApdater {
    [self sessionManager:manager request:url method:@"Get" parameters:parameters headers: headers responseClass:responseClass callbackApdater:callbackApdater];
}

+ (void)updateURL:(NSString *)url
             data:(NSData *)data
   updateFilename:(NSString *)filename
   updateMimeType:(NSString *)mimeType
       parameters:(nullable NSDictionary *)parameters
          headers:(nullable NSDictionary<NSString *,NSString *> *)headers
    responseClass:(nullable Class)responseClass
  callbackApdater:(id<CallbackProtocol>)callbackApdater {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    [manager.requestSerializer setValue:@"multipart/form-data;charset=UTF-8"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:filename forHTTPHeaderField:@"filename"];
    
    [manager POST:url parameters:parameters headers:nil constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {
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
                 }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
                     [self updateWithClass:responseClass sessionDataTask:task responseObject:nil error:error callbackApdater:callbackApdater];
                 }];
}

#pragma mark- 对内方法
+ (void)request:(NSString *)url
        method:(NSString *)method
    parameters:(nullable NSDictionary *)parameters
    headers:(nullable NSDictionary<NSString *,NSString *> *)headers
 responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater  {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager shared];
    [self sessionManager:manager request:url method:method parameters:parameters headers: headers responseClass:responseClass callbackApdater:callbackApdater];
}

+ (void)sessionManager:(AFHTTPSessionManager *)manager
                request:(NSString *)url
                method:(NSString *)method
            parameters:(nullable NSDictionary *)parameters
            headers:(nullable NSDictionary<NSString *,NSString *> *)headers
         responseClass:(nullable Class)responseClass
       callbackApdater:(id<CallbackProtocol>)callbackApdater  {
    
    if ([method isEqualToString:@"Post"]) {
        [manager POST:url parameters:parameters headers:nil progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject) {
                  [self responseSuccessWithClass:responseClass sessionDataTask:task responseObject:responseObject callbackApdater:callbackApdater];
              }
              failure:^(NSURLSessionDataTask *task, NSError *error) {
                  [self responseFailureWithTask:task error:error callbackApdater:callbackApdater];
              }];
    } else if ([method isEqualToString:@"Get"]) {
        [manager GET:url parameters:parameters headers:nil progress:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 [self responseSuccessWithClass:responseClass sessionDataTask:task responseObject:responseObject callbackApdater:callbackApdater];
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 [self responseFailureWithTask:task error:error callbackApdater:callbackApdater];
             }];
    }
}

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

+ (void)responseFailureWithTask:(NSURLSessionDataTask *)task
                          error:(NSError *)error
                callbackApdater:(id<CallbackProtocol>)callbackApdater {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
    NSInteger statusCode = httpResponse.statusCode;
    [callbackApdater exception:error statusCode:statusCode responseStatus:ResponseFailure];
}

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

+ (nullable NSString *)URLEncoding:(NSString *)URL {
    return [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
