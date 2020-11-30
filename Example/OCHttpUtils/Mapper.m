//
//  Mapper.m
//  OCHttpUtils_Example
//
//  Created by season on 2020/11/30.
//  Copyright © 2020 seasonZhu. All rights reserved.
//

#import "Mapper.h"

@implementation NSArray (Map)

@end

@implementation NSArrayMapper

+ (NSArray *)mapArray:(NSArray *)input
           block:(id(^)(id obj))block{
    NSMutableArray * result = [[NSMutableArray alloc] init];
    [input enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [result addObject:block(obj)];
    }];
    return [NSArray arrayWithArray:result];
}
@end
