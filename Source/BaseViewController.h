//
//  BaseViewController.h
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//
#define NAV_BACK_IMG_NAME @"back"

#define COLOR_BACKGROUND    RGB(240, 240, 240)   //底层View背景颜色
#define COLOR_NAV_TITLE     COLOR_THEME//nav标题颜色
#define COLOR_TABLE_HEADER   RGBA(128, 128, 128,1)
#define COLOR_NAV          COLOR(@"#1a1a1a",1) //导航栏颜色
#define COLOR_NAV_BACK      COLOR_THEME  //返回ITEM 按钮颜色
#define COLOR_ITEM          COLOR_THEME  //ITEM 按钮颜色
#define COLOR_THEME         RGB(246,203,173)   //TODO  主题颜色 修改为工程需要的
#define FONT(RatioFont)     [UIFont systemFontOfSize:RatioFont]

#define ANIMATION_DELAY 0.3

#define COLOR_DISABLE_BG    RGB(204, 204, 204)

#define COLOR_BORDER        RGB(242,242,242).CGColor   //TODO  控件外框颜色 修改为工程需要的

#define COLOR_TITLE_DISABLE RGB(180,180,180)

#define COLOR_TOOL_ITEM     RGB(64,64,64)
#define COLOR_LINE          RGBA(238, 238, 238, 1)
#define COLOR_RED           RGB(235,63,54)
#define COLOR_SEPARATE      RGB(186,206,225)  //  分割线、边框颜色

#define RGBA(r,g,b,a)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define RGB(r,g,b)          RGBA(r,g,b,1)

#define COLOR(color,alpha) [Tools colorWithHexString:color withAlpha:alpha]

#define ScreenW    [[UIScreen mainScreen] bounds].size.width
#define ScreenH    [[UIScreen mainScreen] bounds].size.height

#define BORDER_WIDTH  [[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0

/**
 *  系统默认导航栏(44)加状态栏(20)高度
 */
#define NAV_HEIGHT  (ScreenH == 812 ?  88 : 64)

#define STATUS_HEIGHT (ScreenH == 812 ?  44 : 20)
/**
 *  系统默认底部标签栏高度
 */
#define TAB_HEIGHT  (ScreenH == 812 ? 83 : 49)
/**
 * 分页数据每页条数
 */
#define TABLE_PAGE_SIZE 10
/**
 *  加载本地图片
 */
#define LOAD_LOCAL_IMG(imgName)   [UIImage imageNamed:imgName]

//以下是自动适配相关宏定义 不用自动适配可以无视
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#import "ServiceRequest.h"
#import "BaseNavgationController.h"
#import "Tools.h"
#import "CustomHud.h"
#import "NoneView.h"
#import "IQKeyboardManager.h"
#import "CTMediator.h"

@interface BaseViewController : UIViewController

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, strong) BaseNavgationController   *navigationController;

- (void)textStateHUD:(NSString *)text;

- (void)textStateHUDNoHide:(NSString *)text;

-(void)imageStateHUD:(NSString *)imageName title:(NSString *)title;

-(void)hideProgress;

- (BOOL)fd_prefersNavigationBarHidden;

@end
