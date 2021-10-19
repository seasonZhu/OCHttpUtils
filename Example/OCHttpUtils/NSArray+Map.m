//
//  NSArray+Map.m
//  OCHttpUtils_Example
//
//  Created by dy on 2021/10/19.
//  Copyright © 2021 seasonZhu. All rights reserved.
//

#import "NSArray+Map.h"

@implementation NSArray (Map)

- (NSArray *)map:(id(^)(id))handle {
    return [self _map:handle];
}

- (NSArray *)_map:(id(^)(id))handle {
    if (!handle || !self) return self;
    
    NSMutableArray *arr = NSMutableArray.array;
    for (id obj in self) {
        id new = handle(obj);
        [arr addObject:new];
    }
    return [NSArray arrayWithArray:arr];
}

@end
