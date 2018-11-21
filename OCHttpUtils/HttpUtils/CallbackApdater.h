//
//  CallbackApdater.h
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallbackProtocol.h"

typedef void(^CallbackHandle)(id value);
typedef void(^CallbackException)(id exception);

@interface CallbackApdater : NSObject <CallbackProtocol>
/** 正常回调句柄 (Normal callback handle)*/
@property(nonatomic,copy) CallbackHandle handle;

/** 异常回调句柄 (Exception callback handle)*/
@property(nonatomic,copy) CallbackException exception;

/**
 * 回调句柄(Callback handle)
 *
 * @param value 成功回调
 */
- (void)handle:(id)value;

/**
 * 异常处理(Troubleshooting)
 *
 * @param exception 具体的异常信息
 */
- (void)exception:(id)exception;
@end


