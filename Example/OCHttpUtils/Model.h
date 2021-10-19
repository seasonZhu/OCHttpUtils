//
//  Model.h
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>
NS_ASSUME_NONNULL_BEGIN

@interface ListItem: NSObject<YYModel>
@property (nonatomic , copy) NSString *topicTittle;
@property (nonatomic , copy) NSString *upTime;
@property (nonatomic , copy) NSString *topicDesc;
@property (nonatomic , assign) NSInteger numId;
@property (nonatomic , copy) NSString *topicImageUrl;
@property (nonatomic , assign) NSInteger topicStatus;
@property (nonatomic , assign) NSInteger topicOrder;

@end


@interface Model: NSObject<YYModel>
@property (nonatomic , strong) NSArray <ListItem *>  *list;
@property (nonatomic , assign) NSInteger code;

@end

/**
 OC对泛型的支持实在是太弱了 这样写没有什么问题,但是一编译就出问题
 */
@interface BaseResponse<T: NSObject<YYModel> *> : NSObject <YYModel>
@property (nonatomic , assign) NSInteger code;
@property (nonatomic, strong) NSArray<T>  *list;

@end

@interface Response : NSObject <YYModel>
@property (nonatomic , assign) NSInteger code;
@property (nonatomic, strong) id list;

- (nullable id)transformToClass:(nullable Class)toClass;

- (NSArray *)transformToArayyWithClass:(Class)toClass;
@end
NS_ASSUME_NONNULL_END
