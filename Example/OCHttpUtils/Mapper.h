//
//  Mapper.h
//  OCHttpUtils_Example
//
//  Created by season on 2020/11/30.
//  Copyright © 2020 seasonZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//通过Category的方式来添加范型函数是无法正常工作的
@interface NSArray<ObjectType> (Map)

//编译器找不到ResultType
//- (NSArray<ResultType> *)map:(ResultType(^)(ObjectType obj))block;

@end

@interface NSArrayMapper<ObjectType,ResultType>: NSObject

+ (NSArray<ResultType> *)mapArray:(NSArray<ObjectType> *)input
                            block:(ResultType(^)(ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END
