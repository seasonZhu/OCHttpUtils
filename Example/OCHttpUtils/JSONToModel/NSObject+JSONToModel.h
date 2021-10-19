//
//  NSObject+JSONToModel.h
//  OCHttpUtils_Example
//
//  Created by dy on 2021/10/19.
//  Copyright © 2021 seasonZhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONToModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JSONToModel)<JSONToModelProtocol>

- (nullable id)jsonToModelWithClass:(nonnull Class)toClass;

- (nullable NSArray *)jsonToArayyModelsWithClass:(nonnull Class)toClass;

@end

NS_ASSUME_NONNULL_END
