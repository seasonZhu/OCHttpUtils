//
//  HttpUtils.h
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallbackProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/**
 基本请求类,这个类完成了基本请求的回调任务
 */
@interface HttpUtils : NSObject

/**
 post请求
 
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型 为什么responseClass必须是Class类型 而不能是id<YYModel> 因为YYModel中的协议中没有yy_modelWithJSON的方法,而在NSObject<YYModel>的分类中具体方法返回的是instancetype明确的类型
 @param callbackApdater 回调
 */
+ (void)postURL:(NSString *)url parameters:(NSDictionary *)parameters responseClass:(Class)responseClass callbackApdater:(id<CallbackProtocol>)callbackApdater;

/**
 get请求
 
 @param url 网址
 @param parameters 请求字段
 @param responseClass 响应的模型类型
 @param callbackApdater 回调
 */
+ (void)getURL:(NSString *)url parameters:(NSDictionary *)parameters responseClass:(Class)responseClass callbackApdater:(id<CallbackProtocol>)callbackApdater;
@end

NS_ASSUME_NONNULL_END
