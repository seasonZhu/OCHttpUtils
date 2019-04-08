//
//  NetworkListener.h
//  OCHttpUtils
//
//  Created by season on 2019/4/8.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/** 网络变化通知key*/
FOUNDATION_EXPORT NSString * const NetworkDidChangedNotification;

@interface NetworkListener : NSObject
/**
 监听状态
 */
@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus status;

/**
 是否与网络连接
 */
@property (nonatomic, assign, readonly) BOOL isReachable;

/**
 单例

 @return 返回单例
 */
+ (instancetype)shared;

/**
 开始监听
 */
- (void)startMonitoring;

/**
 停止监听
 */
- (void)stopMonitoring;
@end

NS_ASSUME_NONNULL_END
