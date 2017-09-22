//
//  BaseTableViewController.h
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//

#import "BaseViewController.h"
#import "MJRefresh.h"
#import "UITableView+Placeholder.h"

typedef void (^refresh_action)();//用typedef定义一个block类型

@interface BaseTableViewController : BaseViewController <UITableViewDataSource , UITableViewDelegate>

-(id)initWithStyle:(UITableViewStyle)style;

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,assign)BOOL showSeparator;//是否显示cell分割线
@property(nonatomic,assign)UITableViewStyle tableStyle;//列表样式

@property(nonatomic) BOOL ifrespErr;

@property (nonatomic, strong) NSMutableArray *listData;

@property (nonatomic,assign) NSInteger object_count;

@property (nonatomic,assign) BOOL isInit; //是否已经初始化

@property(nonatomic,strong) MJRefreshAutoNormalFooter *footer;

@property (nonatomic, strong) refresh_action footer_action;

@property  (nonatomic, assign) BOOL autoRefresh;

/** 分页需要重载的方法 -- 方法名*/
- (NSString *)method;
/** 分页需要重载的方法 -- 参数*/
- (NSDictionary *)params;
/** 分页需要重载的方法 -- 返回值*/
- (NSArray *)parseResponse:(NSArray *)respDic;

- (void)refresh_data;

- (void)hide_footer;

- (void)show_footer;
/**
 * 增加自定义下啦
 */
- (void)addCustomRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 * 自定义上拉加载响应
 */
- (void)set_custom_footer_action:(refresh_action)brock;

- (void)allow_RefreshControl;

@end
