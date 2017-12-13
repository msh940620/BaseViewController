//
//  NavTitleView.m
//  AFNetworking
//
//  Created by Reminisce on 2017/12/13.
//

#import "NavTitleView.h"
#import "BaseViewController.h"
@implementation NavTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, ScreenW - 90, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = COLOR_NAV_TITLE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18]  != nil ? [UIFont fontWithName:@"PingFang-SC-Medium" size:18] : FONT(18);
    }
    return self;
}

@end
