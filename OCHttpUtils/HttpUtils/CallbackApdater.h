//
//  CallbackApdater.h
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallbackProtocol.h"

@interface CallbackApdater : NSObject<CallbackProtocol>

/**
 成功回调句柄
 */
@property(nonatomic,copy) CallbackHandle handle;


/**
 失败回调句柄
 */
@property(nonatomic,copy) CallbackException exception;

/**
 成功的回调句柄
 
 @param value 回调的值
 @param statusCode 响应的code
 @param httpResponseStatus 响应状态
 */
- (void)handleValue:(id)value statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus;

/**
 失败的回调句柄
 
 @param error 回调的错误
 @param statusCode 响应的code
 @param httpResponseStatus 响应状态
 */
- (void)exception:(NSError *)error statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus;
@end


