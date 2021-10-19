//
//  NSArray+Map.h
//  OCHttpUtils_Example
//
//  Created by dy on 2021/10/19.
//  Copyright © 2021 seasonZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Map)

- (NSArray *)map:(id(^)(id))handle;

@end

NS_ASSUME_NONNULL_END
