//
//  CallbackApdater.m
//  OCHttpUtils
//
//  Created by season on 2018/11/13.
//  Copyright © 2018 season. All rights reserved.
//

#import "CallbackApdater.h"

@implementation CallbackApdater

- (void)handleValue:(id)value statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus {
    _handle(value, statusCode, httpResponseStatus);
}


- (void)exception:(NSError *)error statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus {
    _exception(error, statusCode, httpResponseStatus);
}

- (void)updateResult:(BOOL)result value:(nullable id)value statusCode:(NSInteger)statusCode responseStatus:(HttpResponseStatus)httpResponseStatus error:(nullable NSError *)error {
    _resultHandle(result, value, statusCode, httpResponseStatus, error);
}

- (void)updateProgress:(NSProgress *)progress percent:(double)percent {
    _progressHandle(progress, percent);
}

@end
