//
// Created by Reminisce on 2016/11/5.
// Copyright (c) 2016 Remionisce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTMediator.h"

@class BaseTabbarController;
@class BaseNavgationController;

@interface CTMediator(CTMediatorModuleBaseVCActions)

- (BaseTabbarController *)CTMediator_baseTabBarViewController;

- (BaseNavgationController *)CTMediator_baseNavgationViewControllerWithRootViewController:(UIViewController *)rootViewController;

@end
