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

@interface Response ()

@property (nonatomic, strong) NSArray<id>* data;

/// 类属性
@property (nonatomic, strong, class) id classData;

@end

@implementation Response

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"data": @"list"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    Response *response = [Response new];
    
    if ([response.data isKindOfClass:[NSArray<ListItem *> class]]) {
        return @{
                 @"data": [ListItem class]
                 };
    }
    
    return nil;

}

@end


@implementation BasicResponse

//@dynamic data;

@end

@implementation OneResponse

@dynamic data;

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"data": @"list"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"data": [ListItem class]
             };
}

@end
