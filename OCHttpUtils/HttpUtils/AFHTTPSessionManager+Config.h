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

@end

NS_ASSUME_NONNULL_END
