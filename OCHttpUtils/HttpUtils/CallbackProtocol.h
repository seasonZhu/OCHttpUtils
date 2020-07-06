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
 - UpdateSuccessAndConformYYModel: 上传成功 响应码为200 而且其ResponseClass遵守YYModel协议
 - UpdateSuccessAndNotConformYYModel: 上传成功 响应码为200 而且其ResponseClass不遵守YYModel协议
 - UpdateFailure: 上传失败
 */
typedef NS_ENUM(NSInteger, HttpResponseStatus){
    ResponseSuccessAndConformYYModel = 0,
    ResponseSuccessAndNotConformYYModel,
    ResponseSuccessAndStatusCodeNot200,
    ResponseFailure,
    
    UpdateSuccessAndConformYYModel,
    UpdateSuccessAndNotConformYYModel,
    UpdateFailure
};

/**
 成功的回调

 @param value id类型的值
 @param statusCode 响应码
 @param httpResponseStatus 响应状态
 */
typedef void(^CallbackHandle)(id _Nullable value, NSInteger statusCode, HttpResponseStatus httpResponseStatus);

/**
 失败的回调

 @param error 错误
 @param statusCode 响应码
 @param httpResponseStatus 响应状态
 */
typedef void(^CallbackException)(NSError * _Nullable error, NSInteger statusCode, HttpResponseStatus httpResponseStatus);

/**
 上传结果的回调

 @param result 上传是否成功
 @param value id类型的值
 @param statusCode 响应码
 @param httpResponseStatus 响应状态
 @param error 上传错误,先判断result,最后关注error
 */
typedef void(^UpdateResultHandle)(BOOL result, id _Nullable value, NSInteger statusCode, HttpResponseStatus httpResponseStatus, NSError * _Nullable error);


/**
 上传的进度回调

 @param progress NSProgress
 @param percent 上传百分比
 */
typedef void(^UpdateProgressHandle)(NSProgress * _Nullable progress, double percent);

/**
 回调协议
 */
@protocol CallbackProtocol <NSObject>

@required
/**
 成功回调句柄
 */
@property(nonatomic ,copy, nullable) CallbackHandle handle;


/**
 失败回调句柄
 */
@property(nonatomic ,copy, nullable) CallbackException exception;


/**
 上传回调句柄
 */
@property(nonatomic ,copy, nullable) UpdateResultHandle resultHandle;


/**
 上传进度句柄
 */
@property(nonatomic ,copy, nullable) UpdateProgressHandle progressHandle;

/**
 成功的回调句柄

 @param value 回调的值
 @param statusCode 响应的code
 @param httpResponseStatus 响应状态
 */
- (void)handleValue:(nullable id)value statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus;

/**
 失败的回调句柄

 @param error 回调的错误
 @param statusCode 响应的code
 @param httpResponseStatus 响应状态
 */
- (void)exception:(nullable NSError *)error statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus;


/**
 上传结果的回调句柄

 @param result 上传结果
 @param value 回调的值
 @param statusCode 响应的code
 @param httpResponseStatus 响应状态
 @param error 上传错误
 */
- (void)updateResult:(BOOL)result value:(nullable id)value statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus error:(nullable NSError *)error;


/**
 上传进度的回调句柄

 @param progress NSProgress
 @param percent 百分比
 */
- (void)updateProgress:(nullable NSProgress *)progress percent:(double)percent;

@end
