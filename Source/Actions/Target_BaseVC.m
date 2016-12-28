//
// Created by Reminisce on 2016/11/5.
// Copyright (c) 2016 Remionisce. All rights reserved.
//

#import "Target_BaseVC.h"
#import "BaseTabbarController.h"
#import "BaseNavgationController.h"

@implementation Target_BaseVC

- (BaseTabbarController *)Action_nativeBaseTabBarViewController:(NSDictionary *)params{
    BaseTabbarController *baseTabbarController = [[BaseTabbarController alloc]init];
    return baseTabbarController;
}

- (BaseNavgationController *)Action_nativeBaseNavgationViewController:(NSDictionary *)params{

    UIViewController *viewController = params[@"rootViewController"];
    BaseNavgationController *baseNavgationController = [[BaseNavgationController alloc] initWithRootViewController:viewController];
    return baseNavgationController;
}

@end
