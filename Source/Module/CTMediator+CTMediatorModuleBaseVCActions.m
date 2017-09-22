//
// Created by Reminisce on 2016/11/5.
// Copyright (c) 2016 Remionisce. All rights reserved.
//

#import "CTMediator+CTMediatorModuleBaseVCActions.h"
#import "BaseTabbarController.h"
#import "BaseNavgationController.h"
NSString * const kCTMediatorTargetBaseVC = @"BaseVC";

NSString * const kCTMediatorActionNativeBaseNavgationViewController = @"nativeBaseTabBarViewController";

NSString * const kCTMediatorActionNativeBaseTabBarViewController = @"nativeBaseNavgationViewController";

@implementation CTMediator(CTMediatorModuleBaseVCActions)

- (BaseTabbarController *)CTMediator_baseTabBarViewController
{
    BaseTabbarController *viewController = [self performTarget:kCTMediatorTargetBaseVC
                                                      action:kCTMediatorActionNativeBaseNavgationViewController
                                                      params:@{}
                                           shouldCacheTarget:NO
    ];
    if ([viewController isKindOfClass:[BaseTabbarController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[BaseTabbarController alloc] init];
    }
}

- (BaseNavgationController *)CTMediator_baseNavgationViewControllerWithRootViewController:(UIViewController *)rootViewController{
    BaseNavgationController *viewController = [self performTarget:kCTMediatorTargetBaseVC
                                                      action:kCTMediatorActionNativeBaseTabBarViewController
                                                      params:@{@"rootViewController":rootViewController}
                                           shouldCacheTarget:NO
    ];
    if ([viewController isKindOfClass:[BaseNavgationController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[BaseNavgationController alloc] init];
    }
}


@end
