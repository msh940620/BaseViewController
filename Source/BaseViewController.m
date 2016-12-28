
//
//  BaseViewController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//


#import "BaseViewController.h"
#import "CTMediator.h"
#import "CTMediator+CTMediatorModuleBaseVCActions.h"

@interface BaseViewController ()<MBProgressHUDDelegate,UIAlertViewDelegate>{
    
    MBProgressHUD *progressView;
}

@end

@implementation BaseViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = COLOR_BACKGROUND;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES animated:YES];
    [self createTitleLabel];
    
    self.view.autoresizesSubviews = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSNotificationCenter *center = [NSNotificationCenter  defaultCenter];
    [center addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)createTitleLabel {
    
    //Create custom label for titleView
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 90, 40)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.textColor = COLOR_NAV_TITLE;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:17];
    self.navigationItem.titleView = _titleLabel;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if(nil != progressView){
        
        [progressView hideAnimated:YES];
        
    }
    [[NSNotificationCenter  defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
    
}
#pragma mark -- HUD 展示text
- (void)textStateHUD:(NSString *)text
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:1.5];
}
- (void)textStateHUD:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:delay];
}

-(void)imageStateHUD:(NSString *)imageName title:(NSString *)title{
    
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeCustomView;
    UIImage *image = [UIImage imageNamed:imageName];
    progressView.customView = [[UIImageView alloc] initWithImage:image];
    progressView.square = YES;
    progressView.detailsLabel.text = title;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:1.5];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- logIn kvc

- (void)defaultsChanged:(NSNotification *)notification {
    NSLog(@"notifaication ------ %@",notification);
    // Get the user defaults
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    // Do something with it
    if(nil != [defaults objectForKey:@"token"]){
        if([[defaults objectForKey:@"token"] isEqualToString:@"logOut"]){
            return;
        }
        if([[defaults objectForKey:@"token"] isEqualToString:@"otherLog"]){
            [[NSNotificationCenter  defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您的账号自动登录失效，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertView.tag = 10086;
            [alertView show];
        }
    }
}


@end
