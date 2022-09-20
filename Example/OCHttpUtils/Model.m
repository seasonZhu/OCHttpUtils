//
//  Model.m
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import "Model.h"
#import "NSArray+Map.h"

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


@interface BaseResponse<__contravariant T: NSObject<YYModel> *> ()

@end

@implementation BaseResponse

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{
             @"list": [NSObject<YYModel> class]
             };
}

@end

@implementation Response

- (nullable id)jsonToModelWithClass:(nonnull Class)toClass {
    if ([toClass conformsToProtocol:@protocol(YYModel)]) {
        id value = [toClass yy_modelWithJSON: self.list];
        return value;
    }else {
        return nil;
    }
}

- (nullable NSArray *)jsonToArayyModelsWithClass:(nonnull Class)toClass {
    if (![toClass conformsToProtocol:@protocol(YYModel)]) {
        return nil;
    }
    
    NSArray<id> *array = (NSArray<id>* )self.list;
    if (array == nil) {
        return nil;
    }
    
    if ([toClass conformsToProtocol:@protocol(YYModel)]) {
        NSArray *newArray = [array map:^id _Nonnull(id _Nonnull element) {
            id value = [toClass yy_modelWithJSON: element];
            return  value;
        }];
        return newArray;
    }else {
        return nil;
    }
}

@end
