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

NS_ASSUME_NONNULL_END
