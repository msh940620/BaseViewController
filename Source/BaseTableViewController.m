//
//  BaseTableViewController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//

#import "NetBrokenViewController.h"
#import "BaseTableViewController.h"
#import "CTMediator+CTMediatorModuleNoneViewActions.h"


@interface BaseTableViewController ()

@property(nonatomic) NSInteger next_page;//下一页
@property(nonatomic) NSInteger list_count;//总页数
@property (nonatomic, strong) UIView *noneView;

@end

@implementation BaseTableViewController

-(UIView *)noneView{
    if(!_noneView){
        _noneView = [[CTMediator sharedInstance] CTMediator_noneViewWithTitle:@"网络错误"
                                                                      noneDec:@"请检查网络后重试"
                                                                 noneBtnTitle:@"重试"
                                                                        Image:@"ic_network_emptydata"
                                                                    withWidth:114
                                                                   withHeight:90
                                                                        img_y:120
                                                                       height:self.tableview.frame.size.height
                                                                        block:^{
                                                                            [self refresh_data];
                                                                        }];
    }
    return _noneView;
}

-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.showSeparator = YES;
        self.tableStyle = style;
        self.ifrespErr = NO;
        self.isInit = NO;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        self.showSeparator = YES;
        self.tableStyle = UITableViewStyleGrouped;
        self.ifrespErr = NO;
        self.isInit = NO;
    }
    return self;
}

- (void)loadView{
    [super loadView];
    
    //tableView 基本初始化
    if (!self.tableview) {
        CGRect vFrame = CGRectMake(0,0,ScreenW,ScreenH);
        vFrame.size.height = self.navigationController.navigationBarHidden?vFrame.size.height:vFrame.size.height-NAV_HEIGHT;
        if(!self.hidesBottomBarWhenPushed){
            vFrame.size.height = self.tabBarController.tabBar.hidden?vFrame.size.height:vFrame.size.height-TAB_HEIGHT;
        }
        self.tableview = [[UITableView alloc] initWithFrame:vFrame style:self.tableStyle];
        self.tableview.rowHeight = UITableViewAutomaticDimension;
        self.tableview.estimatedRowHeight = 44;
        self.tableview.dataSource = self;
        self.tableview.delegate = self;
        self.tableview.backgroundColor = COLOR_BACKGROUND;
        self.tableview.showsVerticalScrollIndicator = NO;
        self.tableview.showsHorizontalScrollIndicator = NO;
        self.tableview.separatorColor = COLOR_BACKGROUND;
        [self.view addSubview:self.tableview];
        /**
         * 去除页面上边距
         */
        self.edgesForExtendedLayout = UIRectEdgeBottom;
    }
    //不显示cell分割线
    if (!self.showSeparator) {
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self method] !=nil) {
        [self show_footer];
        [self allow_RefreshControl];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.isInit){
        [self.tableview reloadData];
    }
}

- (NSMutableArray *)listData{
    if(!_listData){
        _listData = [NSMutableArray array];
    }
    return _listData;
}

- (void)addCustomRefresh:(MJRefreshComponentRefreshingBlock)refreshingBlock{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:refreshingBlock];
    // 设置文字
    //    [header setTitle:@"下拉可以刷新了" forState:MJRefreshStateIdle];
    //    [header setTitle:@"松开马上刷新了" forState:MJRefreshStatePulling];
    //    [header setTitle:@"刷新中。。。" forState:MJRefreshStateRefreshing];
    //    header.arrowView.image = [UIImage imageNamed:@"ic_refresh"];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    // 菊花样式
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    // 设置颜色
    header.stateLabel.textColor = COLOR_TABLE_HEADER;
    // 设置刷新控件
    self.tableview.mj_header = header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)allow_RefreshControl{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh_data)];
    // 设置文字
    //    [header setTitle:@"下拉可以刷新了" forState:MJRefreshStateIdle];
    //    [header setTitle:@"松开马上刷新了" forState:MJRefreshStatePulling];
    //    [header setTitle:@"刷新中。。。" forState:MJRefreshStateRefreshing];
    //    header.arrowView.image = [UIImage imageNamed:@"ic_refresh"];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    // 设置颜色
    header.stateLabel.textColor = COLOR_TABLE_HEADER;
    // 设置刷新控件
    self.tableview.mj_header = header;
}

#pragma mark -- 加载第一页数据 分页需调用
- (void)show_footer
{
    self.next_page = 1;
    self.list_count = 0;
    self.isInit = NO;
    self.listData = [[NSMutableArray alloc] init];
    
    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    // 设置文字
    [_footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [_footer setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
    [_footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [_footer setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
    // 设置字体
    _footer.stateLabel.font = FONT(15);
    // 设置颜色
    _footer.stateLabel.textColor = COLOR_TABLE_HEADER;
    // 设置footer
    self.tableview.mj_footer = _footer;
    
    self.tableview.needPlaceholder = @(1);
    
    [self getData];
    
}

- (void)refresh_data{
    
    if(self.isInit){
        _next_page = 1;
        if(self.tableview.mj_footer){
            [self.tableview.mj_footer resetNoMoreData];
        }
        [self getData];
    }
    
}

/**
 * 获取数据
 */
- (void)getData{
    
    if(_footer_action){
        _footer_action();
    }else{
        
        NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
        if ([self params]== nil) {
            //传page
            paramDic[@"currentPage"] = [NSString stringWithFormat:@"%ld",(long)_next_page];
            paramDic[@"pageSize"] = [NSString stringWithFormat:@"%d",TABLE_PAGE_SIZE];
        }else{
            //合并(page + params)
            [paramDic setDictionary:[self params]];
            paramDic[@"currentPage"] = [NSString stringWithFormat:@"%ld",(long)_next_page];
            paramDic[@"pageSize"] = [NSString stringWithFormat:@"%d",TABLE_PAGE_SIZE];
        }
        [ServiceRequest loadWithMethodName:[self method] andHttpMethod:HttpMethodPost andParams:paramDic successed:^(id respDic, NSString *code, NSString *message) {
            if(!_isInit){
                _isInit = YES;
            }
            self.noneView.hidden = YES;
            self.tableview.hidden = NO;
            [self calculateListCount:respDic];
            if(_object_count < 10){
                self.tableview.mj_footer = nil;
            }else{
                if(!self.tableview.mj_footer){
                    
                    _footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getData)];
                    // 设置文字
                    [_footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
                    [_footer setTitle:@"松开加载更多" forState:MJRefreshStatePulling];
                    [_footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
                    [_footer setTitle:@"没有更多了哦" forState:MJRefreshStateNoMoreData];
                    // 设置字体
                    _footer.stateLabel.font = FONT(15);
                    // 设置颜色
                    _footer.stateLabel.textColor = COLOR_TABLE_HEADER;
                    // 设置footer
                    self.tableview.mj_footer = _footer;
                    
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray * items;
                items = [self parseResponse:respDic[@"dataList"]];
                //        NSArray * items = [self parseResponse:respDic[@"workorderlist"]];
                if (items && [items count]){
                    
                    // 如果下一页为2 当前页则为1 需要对list重置
                    if(_next_page == 2){
                        _listData = [NSMutableArray array];
                    }
                    _listData = [[_listData arrayByAddingObjectsFromArray:items] mutableCopy];
                }else{
                    if(!_listData || _next_page == 2){
                        _listData = [NSMutableArray array];
                    }
                }
                [CustomHud hiddenAllHudAfter:0];
                _ifrespErr = NO;
                
                [self.tableview reloadData];
            });
        } failed:^(id respDic, NSString *code, NSString *message) {
            if(!_isInit){
                _isInit = YES;
            }
            [CustomHud hiddenAllHudAfter:0];
            if(_object_count < 10){
                self.tableview.mj_footer = nil;
            }
            if (self.tableview.mj_footer) {
                if([code isEqualToString:NO_MORE_DATA]){
                    [self.tableview.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableview.mj_footer endRefreshing];
                }
            }
            if (self.tableview.mj_header) {
                [self.tableview.mj_header endRefreshing];
            }
            
            _ifrespErr = YES;
            if ([code isEqualToString:NO_INTERNET_ERR_CODE]){
                self.object_count = 0;
                self.list_count = 0;
                self.next_page = 1;
                self.tableview.hidden = YES;
                [self.view addSubview:self.noneView];
                self.noneView.hidden = NO;
                
            }
            [self textStateHUD:message];
            [_tableview reloadData];
        }];
    }
}

- (void)turnToPromptPage{
    NetBrokenViewController *brokenVC = [[NetBrokenViewController alloc] init];
    [self.navigationController pushViewController:brokenVC animated:YES];
}

- (void)hide_footer{
    if(self.tableview.mj_footer){
        self.tableview.mj_footer = nil;
    }
}

//重新刷新页面
- (void)resetLoad{
    [self getData];
}

//////////////////////////////////////////////////////////////////////////////////
#pragma mark - tableview datasource && tableview delegate
//常规表格的数据和委托

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.5;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * LOAD_MORE_CELL = @"LOAD_MORE_CELL_IDENTIFITY";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:LOAD_MORE_CELL];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LOAD_MORE_CELL];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.tableview) {
        if (_next_page -1 < _list_count && nil != self.method && _object_count > 0 && !_ifrespErr) {
            if (indexPath.section == self.listData.count - 1 || indexPath.row ==self.listData.count - 1) {
                [self getData];
            }
        }
    }
}

//计算总个数
- (void)calculateListCount:(NSDictionary *)respDic{
    
    _list_count = [respDic[@"totalpages"] integerValue];
    _next_page = [respDic[@"currentpageNo"] integerValue] + 1;
    _object_count = [respDic[@"returntotalcount"] integerValue];
    
    if (_next_page > _list_count) {
        if (self.tableview.mj_footer) {
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
        }
        if (self.tableview.mj_header) {
            [self.tableview.mj_header endRefreshing];
        }
    }else if(_object_count == 0){
        [self hide_footer];
    }else{
        if (self.tableview.mj_footer) {
            [self.tableview.mj_footer endRefreshing];
        }
        if (self.tableview.mj_header) {
            [self.tableview.mj_header endRefreshing];
        }
    }
}

#pragma mark - 基本方法(需要分页的页面 重写)

- (NSString *)method{
    return nil;
}

- (NSDictionary *)params{
    return nil;
}

//解析返回的数据
- (NSArray *)parseResponse:(NSArray *)respDic
{
    return nil;
}

- (void)set_custom_footer_action:(refresh_action)brock{
    self.footer_action = brock;
}



@end
