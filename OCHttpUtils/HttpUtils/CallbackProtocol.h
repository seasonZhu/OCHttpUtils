//
//  CallbackProtocol.h
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

/**
 响应状态枚举

 - ResponseSuccessAndConformYYModel: 响应成功 响应码为200 而且其ResponseClass遵守YYModel协议
 - ResponseSuccessAndNotConformYYModel: 响应成功 响应码为200 而且其ResponseClass不遵守YYModel协议
 - ResponseSuccessAndStatusCodeNot200: 响应成功 响应码不为200
 - ResponseFailure: 响应失败
 */
typedef NS_ENUM(NSInteger, HttpResponseStatus){
    ResponseSuccessAndConformYYModel,
    ResponseSuccessAndNotConformYYModel,
    ResponseSuccessAndStatusCodeNot200,
    ResponseFailure
};

/**
 成功的回调

 @param value id类型的值
 @param statusCode 响应码
 @param httpResponseStatus 响应状态
 */
typedef void(^CallbackHandle)(id value, NSInteger statusCode, HttpResponseStatus httpResponseStatus);

/**
 失败的回调

 @param error 错误
 @param statusCode 响应码
 @param httpResponseStatus 响应状态
 */
typedef void(^CallbackException)(NSError *error, NSInteger statusCode, HttpResponseStatus httpResponseStatus);

/**
 回调协议
 */
@protocol CallbackProtocol <NSObject>

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
