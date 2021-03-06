
//
//  BaseViewController.m
//  schoolConnection
//
//  Created by Remionisce on 16/7/12.
//  Copyright © 2016年 Remionisce. All rights reserved.
//


#import <CommonCell/CommonCellSetting.h>
#import "BaseViewController.h"
#import "CTMediator.h"
#import "CTMediator+CTMediatorModuleBaseVCActions.h"
#import "UIViewController+ChooseResources.h"
#import "CommonUserInfo.h"
#import "NavTitleView.h"
#import <Masonry/Masonry.h>

@interface BaseViewController ()<MBProgressHUDDelegate,UIAlertViewDelegate>{
    
    MBProgressHUD *progressView;

}

@property  (nonatomic, strong)  NavTitleView *navTitleView;

@end

@implementation BaseViewController

- (NavTitleView *)navTitleView {
    if(!_navTitleView){
        _navTitleView = [[NavTitleView alloc] init];
    }
    return _navTitleView;
}

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
    self.titleLabel.text = self.title;
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

    self.navigationItem.titleView = self.navTitleView;
    _titleLabel = self.navTitleView.titleLabel;

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
            dispatch_async(dispatch_get_main_queue(), ^{
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:1.5];
                   });
}
- (void)textStateHUD:(NSString *)text afterDelay:(NSTimeInterval)delay
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
        dispatch_async(dispatch_get_main_queue(), ^{
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeText;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
    [progressView hideAnimated:YES afterDelay:delay];
               });
}

- (void)textStateHUDNoHide:(NSString *)text
{
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
    [self.view addSubview:progressView];
    progressView.mode = MBProgressHUDModeIndeterminate;
    progressView.detailsLabel.text = text;
    progressView.detailsLabel.font = [UIFont systemFontOfSize:13.0f];
    //stateHud.labelFont = [UIFont systemFontOfSize:13.0f];
    [progressView showAnimated:YES];
         });
}

-(void)hideProgress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [progressView hideAnimated:NO];
    });
}

-(void)imageStateHUD:(NSString *)imageName title:(NSString *)title{
    
    if (!progressView) {
        progressView = [[MBProgressHUD alloc] initWithView:self.view];
        progressView.delegate = self;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
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
            });
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -- logIn kvc

- (void)defaultsChanged:(NSNotification *)notification {
    // Get the user defaults
    NSUserDefaults *defaults = (NSUserDefaults *)[notification object];
    // Do something with it
    if(nil != [defaults objectForKey:@"token"]){
        if([[CommonUserInfo sharedInstance] isLogin] || [Tools isEmpty:[CommonUserInfo sharedInstance].token]){
            return;
        }
        if([[defaults objectForKey:@"token"] isEqualToString:@"otherLog"]){
            [[NSNotificationCenter  defaultCenter] removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
            [[CommonUserInfo sharedInstance] logOut];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"您的账号已在其他地方登录，请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertView.tag = 10086;
            [alertView show];
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if(actionSheet.tag == 1004){
        switch (buttonIndex){
                
            case 0:{
                NSLog(@"相册");
                //            ZYQAssetPickerController *zyqAssetPickerController = [[ZYQAssetPickerController alloc] init];
                //            zyqAssetPickerController.maximumNumberOfSelection = actionSheet.tag;
                //            zyqAssetPickerController.assetsFilter = [ALAssetsFilter allAssets];
                //            zyqAssetPickerController.showEmptyGroups = NO;
                //            zyqAssetPickerController.delegate = self;
                //            zyqAssetPickerController.navigationBar.translucent = NO;
                //            zyqAssetPickerController.navigationBar.barTintColor = [UIColor whiteColor];
                //            [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
                //            [rootViewController presentViewController:zyqAssetPickerController animated:YES completion:nil];
                [self pushImagePickerController:[self.maxCount integerValue] allowVideo:[self.allowVideo integerValue] allowImg:[self.allowImg integerValue]];
                break;
            }
                
            case 1:{
                NSLog(@"拍照");
                [self takePhoto];
                break;
            }
                
            default:
                break;
                
        }
        
    }else if(actionSheet.tag == 1005){
        
        switch (buttonIndex){
                
            case 0:{
                [self pushImagePickerController:[self.maxCount integerValue] allowVideo:[self.allowVideo integerValue] allowImg:[self.allowImg integerValue]];
                break;
            }
            case 1:{
                if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                    
                    
                    UIImagePickerController *cameraPicker = [[UIImagePickerController alloc] init];
                    
                    cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;//sourcetype有三种分别是camera，photoLibrary和photoAlbum
                    
                    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
                    
                    cameraPicker.mediaTypes = @[availableMedia[1]];//设置媒体类型为public.movie
                    
                    cameraPicker.videoMaximumDuration = 30.0f;//30秒
                    
                    cameraPicker.delegate = self;//设置委托
                    
                    cameraPicker.view.tag = 101;
                    
                    [self presentViewController:cameraPicker animated:YES completion:nil];
                } else{
                    if([self isKindOfClass:[BaseViewController class]]){
                        BaseViewController *viewController = (BaseViewController *)self;
                        [viewController textStateHUD:@"此设备摄像不可用"];
                    }
                }
                break;
            }
            default:
                break;
        }
    }
}

- (BOOL)fd_prefersNavigationBarHidden {
    return NO;
}


@end
