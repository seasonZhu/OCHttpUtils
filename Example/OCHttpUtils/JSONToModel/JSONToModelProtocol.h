//
//  JSONToModelProtocol.h
//  OCHttpUtils
//
//  Created by dy on 2021/10/19.
//  Copyright © 2021 seasonZhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef JSONToModelProtocol_h
#define JSONToModelProtocol_h

@protocol JSONToModelProtocol <NSObject>

@required

- (nullable id)jsonToModelWithClass:(nonnull Class)toClass;

- (nullable NSArray *)jsonToArayyModelsWithClass:(nonnull Class)toClass;

@end
#endif /* JSONToModelProtocol_h */
