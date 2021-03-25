//
//  NetworkListener.h
//  OCHttpUtils
//
//  Created by season on 2019/4/8.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

/// 网络变化通知key 其实AFN中已经定义了一个监听网络变化的通知名,你完全可以直接使用它的通知名去进行监听,这里使用自己的,只是为了避免混淆
FOUNDATION_EXPORT NSString * const NetworkDidChangedNotification;

@interface NetworkListener : NSObject

/// 监听状态
@property (nonatomic, assign, readonly) AFNetworkReachabilityStatus status;

/// 是否与网络连接
@property (nonatomic, assign, readonly) BOOL isReachable;

/// 单例
+ (instancetype)shared;

/// 开始监听
- (void)startMonitoring;

/// 停止监听
- (void)stopMonitoring;
@end

NS_ASSUME_NONNULL_END
