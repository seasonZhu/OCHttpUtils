//
//  AFHTTPSessionManager+Config.m
//  OCHttpUtils
//
//  Created by season on 2019/5/27.
//  Copyright © 2019 season. All rights reserved.
//

#import "AFHTTPSessionManager+Config.h"

static AFHTTPSessionManager *sessionManager = nil;

@implementation AFHTTPSessionManager (Config)

#pragma mark- 对外方法
+ (AFHTTPSessionManager *)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 30.0;
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/force-download", @"application/soap+xml; charset=utf-8",@"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/html; charset=iso-8859-1", @"text/html; charset=utf-8", @"text/plain",@"text/css",@"application/x-plist",@"image/*", nil];
    });
    return sessionManager;
}

- (AFHTTPSessionManager *)setHTTPHeaders:(NSDictionary *)headers {
    AFHTTPSessionManager *manager = self;
    for (NSString *key in headers) {
        NSString *value = headers[key];
        [manager.requestSerializer setValue:value forHTTPHeaderField:key];
    }
    
    return manager;
}

- (AFHTTPSessionManager *)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    AFHTTPSessionManager *manager = self;
    manager.requestSerializer.timeoutInterval = timeoutInterval;
    
    return manager;
}

- (AFHTTPSessionManager *)securityPolicyWithCerPath:(NSString *)path fileName:(NSString *)fileName password:(NSString *)password {
    NSData *certData = [NSData dataWithContentsOfFile:path];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    NSSet *set = [NSSet setWithArray:@[certData]];
    [securityPolicy setPinnedCertificates:set];
    AFHTTPSessionManager *manager = self;
    [manager setSecurityPolicy:securityPolicy];
    
    // 关闭缓存避免干扰测试r
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];

    // 启用双向认证需要下面的代码，如果只是单向认证则不需要下面代码，下面是开启客户端验证的代码。
    __weak typeof(manager)weakSelf = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession* session,
                                                                                                    NSURLAuthenticationChallenge* challenge,
                                                                                                    NSURLCredential* __autoreleasing* _credential) {
        __strong typeof(manager) man = weakSelf;
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        // 服务端认证
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if([man.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if(credential) {
                    disposition =NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // 客户端验证
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            //客户端证书路径
            NSString *p12 = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            if (![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            } else {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data password:password]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                    CFRelease(certArray);
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
    return manager;
}

#pragma mark- 请求的状态
- (NSURLSessionTaskState)requestTaskStateWith:(NSString *)URL {
    NSURLSessionTask *task = [self requestTaskWith:URL];
    return task == nil ? NSURLSessionTaskStateCanceling : task.state;
}

- (nullable NSURLSessionTask *)requestTaskWith:(NSString *)URL {
    AFHTTPSessionManager *manager = self;
    for (NSURLSessionTask *task in manager.tasks) {
        BOOL isTask = [task.originalRequest.URL.absoluteString isEqualToString:URL];
        if (isTask) {
            return task;
        }
        //服务器重定向导致的request变更,这个地方理解不深,可能出现错误
        isTask = [task.currentRequest.URL.absoluteString isEqualToString:URL];
        if (isTask) {
            return task;
        }
    }
    return nil;
}

#pragma mark- 请求取消/暂停/恢复操作
- (void)cancelAllTasksAndOperationQueues {
    AFHTTPSessionManager *manager = self;
    for (NSURLSessionTask *task in manager.tasks) {
        [task cancel];
    }
    [manager.operationQueue cancelAllOperations];
}

- (void)cancelTaskWithURL:(NSString *)URL {
    NSURLSessionTask *task = [self requestTaskWith:URL];
    [task cancel];
}

- (void)suspendTaskWithURL:(NSString *)URL {
    NSURLSessionTask *task = [self requestTaskWith:URL];
    [task suspend];
}

- (void)resumeTaskWithURL:(NSString *)URL {
    NSURLSessionTask *task = [self requestTaskWith:URL];
    [task resume];
}

#pragma mark- 对内方法
- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data password:(NSString *)password {
    OSStatus securityError = errSecSuccess;
    //客户端证书密码
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:password
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity =NULL;
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust =NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        return NO;
    }
    return YES;
}

@end
