//
//  CallbackApdater.m
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

#import "CallbackApdater.h"

@implementation CallbackApdater

-(void) handle:(id) value {
    _handle(value);
}

-(void) exception:(id) exception {
    _exception(exception);
}

@end
