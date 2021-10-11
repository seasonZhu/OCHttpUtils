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

@implementation BaseResponse

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"list": [NSObject<YYModel> class]
             };
}

@end
