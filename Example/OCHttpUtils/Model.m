//
//  Model.m
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import "Model.h"

@implementation ListItem
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"numId": @"id"
             };
}
@end


@implementation Model
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"list": [ListItem class]
             };
}
@end

@interface BaseResponse ()

@end

@implementation BaseResponse

/// 就目前这个情况看,在OC中使用的泛型想要配合YYModel是一件非常困难的事情
//+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
//    return @{
//             @"list": [ObjectType class]
//             };
//}

@end
