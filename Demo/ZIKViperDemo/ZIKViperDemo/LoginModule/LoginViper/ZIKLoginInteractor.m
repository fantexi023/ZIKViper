//
//  ZIKLoginInteractor.m
//  ZIKViperDemo
//
//  Created by zuik on 2017/7/15.
//  Copyright © 2017 zuik. All rights reserved.
//

#import "ZIKLoginInteractor.h"
#import <ZIKViper/ZIKViperInteractorPrivate.h>
#import "ZIKLoginServiceInput.h"
#import "ZIKLoginServiceRouter.h"

@interface ZIKLoginInteractor ()
@property (nonatomic, strong) id<ZIKLoginServiceInput> loginService;
@end

@implementation ZIKLoginInteractor

- (id<ZIKLoginServiceInput>)loginService {
    if (!_loginService) {
        NSAssert([ZIKServiceRouterForService(_ZIKLoginServiceInput_) completeSynchronously] == YES, @"Can get service synchronously.");
        __block id<ZIKLoginServiceInput> loginService;
        [ZIKServiceRouterForService(_ZIKLoginServiceInput_)
         performWithConfigure:^(__kindof ZIKServiceRouteConfiguration * _Nonnull config) {
            config.prepareForRoute = ^(id  _Nonnull destination) {
                
            };
            config.routeCompletion = ^(id  _Nonnull destination) {
                loginService = destination;
            };
        }];
        
        NSAssert(loginService, nil);
        _loginService = loginService;
    }
    return _loginService;
}

- (void)loginWithAccount:(NSString *)account
                password:(NSString *)password
                 success:(void(^_Nullable)(void))successHandler
                   error:(void(^_Nullable)(void))errorHandler {
    [self.loginService loginWithAccount:account password:password success:successHandler error:errorHandler];
}

@end
