//
//  HttpUtils.h
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallbackProtocol.h"
@class AFHTTPSessionManager;

NS_ASSUME_NONNULL_BEGIN

/**
 基本请求类,这个类完成了基本请求的回调任务
 */
@interface HttpUtils : NSObject

/**
 post请求
 
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型 为什么responseClass必须是Class类型 而不能是id<YYModel> 因为YYModel中的协议中没有yy_modelWithJSON的方法,而在NSObject<YYModel>的分类中具体方法返回的是instancetype明确的类型
 @param callbackApdater 回调
 */
+ (void)postURL:(NSString *)url
     parameters:(nullable NSDictionary *)parameters
  responseClass:(nullable Class)responseClass
callbackApdater:(id<CallbackProtocol>)callbackApdater;

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
callbackApdater:(id<CallbackProtocol>)callbackApdater;

/**
 配置化AFHTTPSessionManager的post请求
 
 @param manager 自定义的AFHTTPSessionManager
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)sessionManager:(AFHTTPSessionManager *)manager
               postURL:(NSString *)url
            parameters:(nullable NSDictionary *)parameters
         responseClass:(nullable Class)responseClass
       callbackApdater:(id<CallbackProtocol>)callbackApdater;

/**
 配置化AFHTTPSessionManager的get请求
 
 @param manager 自定义的AFHTTPSessionManager
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)sessionManager:(AFHTTPSessionManager *)manager
                getURL:(NSString *)url
            parameters:(nullable NSDictionary *)parameters
         responseClass:(nullable Class)responseClass
       callbackApdater:(id<CallbackProtocol>)callbackApdater;

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
  callbackApdater:(id<CallbackProtocol>)callbackApdater;

@end

NS_ASSUME_NONNULL_END
