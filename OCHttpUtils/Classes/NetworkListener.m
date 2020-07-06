//
//  NetworkListener.m
//  OCHttpUtils
//
//  Created by season on 2019/4/8.
//  Copyright © 2019 season. All rights reserved.
//

#import "NetworkListener.h"

NSString * const NetworkDidChangedNotification = @"NetworkDidChangedNotification";

static NetworkListener *listener = nil;

@implementation NetworkListener

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        listener = [[self alloc] init];
    });
    return listener;
}

- (void)startMonitoring {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self->_status = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:NetworkDidChangedNotification object:@(status)];
    }];
}

- (void)stopMonitoring {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (BOOL)isReachable {
    if(_status == AFNetworkReachabilityStatusUnknown || _status == AFNetworkReachabilityStatusNotReachable)  return NO;
    return YES;
}
@end
