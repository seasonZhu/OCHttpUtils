//
//  Model.h
//  OCHttpUtils
//
//  Created by season on 2019/4/3.
//  Copyright © 2019 season. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel/YYModel.h>
NS_ASSUME_NONNULL_BEGIN

#pragma mark- 一般思路

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

#pragma mark- 泛型思路

@interface BaseResponse<ObjectType: id<YYModel>> : NSObject <YYModel>
@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, strong) NSArray<ObjectType>  *list;
@end


@interface Response<T: id<YYModel>> : NSObject <YYModel>

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong, readonly) NSArray<T> *data;

@end

#pragma mark- 继承思路

@interface BasicResponse: NSObject <YYModel>

@property (nonatomic, strong) NSNumber *code;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, strong) id data;

@end

@interface OneResponse : BasicResponse

@property (nonatomic, strong) NSArray <ListItem *>  *data;

@end

NS_ASSUME_NONNULL_END
