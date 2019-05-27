//
//  AFHTTPSessionManager+Config.h
//  OCHttpUtils
//
//  Created by season on 2019/5/27.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFHTTPSessionManager (Config)
/**
 AFHTTPSessionManager的默认单例
 
 @return 单例
 */
+ (AFHTTPSessionManager *)shared;

/**
 配置AFHTTPSessionManager的请求头
 
 @param header 请求头
 @return AFHTTPSessionManager
 */
- (AFHTTPSessionManager *)setHTTPHeader:(NSDictionary *)header;

/**
 配置AFHTTPSessionManager的超时时间
 
 @param timeoutInterval 超时时间
 @return AFHTTPSessionManager
 */
- (AFHTTPSessionManager *)setTimeoutInterval:(NSTimeInterval)timeoutInterval;

/**
 配置AFHTTPSessionManager的Https认证
 
 @param path 服务端认证的数据路径
 @param fileName 客户端认证的文件名(包括文件类型)
 @param password 客户端认证的密码
 @return AFHTTPSessionManager
 */
- (AFHTTPSessionManager *)securityPolicyWithCerPath:(NSString *)path fileName:(NSString *)fileName password:(NSString *)password;

/**
 获取当前的请求状态
 
 @param URL 请求网址
 @return 请求状态 可能为空
 */
- (NSURLSessionTaskState)requestTaskStateWith:(NSString *)URL;

/**
 通过URL获取当前的NSURLSessionTask
 
 @param URL 请求网址
 @return NSURLSessionTask 可能为空
 */
- (nullable NSURLSessionTask *)requestTaskWith:(NSString *)URL;

#pragma mark- 请求取消/暂停/恢复操作

/**
 取消所有的请求,和所有的NSURLSessionTask回调代理
 */
- (void)cancelAllTasksAndOperationQueues;

/**
 取消单个请求
 
 @param URL 请求网址
 */
- (void)cancelTaskWithURL:(NSString *)URL;

/**
 暂停单个请求
 
 @param URL 请求网址
 */
- (void)suspendTaskWithURL:(NSString *)URL;


/**
 恢复单个请求
 
 @param URL 请求网址
 */
- (void)resumeTaskWithURL:(NSString *)URL;


@end

NS_ASSUME_NONNULL_END
