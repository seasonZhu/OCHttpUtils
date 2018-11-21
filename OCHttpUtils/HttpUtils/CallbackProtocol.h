//
//  CallbackProtocol.h
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

@protocol CallbackProtocol <NSObject>

/**
 * 回调句柄(Callback handle)
 *
 * @param value 成功回调
 */
- (void)handle:(id)value;

/**
 * 异常处理(Troubleshooting)
 *
 * @param exception 异常信息回调
 */
- (void)exception:(id)exception;

@end
