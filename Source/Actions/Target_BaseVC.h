//
// Created by Reminisce on 2016/11/5.
// Copyright (c) 2016 Remionisce. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseTabbarController;
@class BaseNavgationController;

@interface Target_BaseVC : NSObject

- (BaseTabbarController *)Action_nativeBaseTabBarViewController:(NSDictionary *)params;

- (BaseNavgationController *)Action_nativeBaseNavgationViewController:(NSDictionary *)params;

@end
