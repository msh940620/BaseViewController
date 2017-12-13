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
        self.frame = CGRectMake(0, 0, ScreenW - 170 , 40);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, ScreenW - 90, 40)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textColor = COLOR_NAV_TITLE;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18]  != nil ? [UIFont fontWithName:@"PingFang-SC-Medium" size:18] : FONT(18);
        [self addSubview:_titleLabel];
        [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.leading.offset(0);
            make.top.offset(0);
            make.trailing.offset(0);
            make.bottom.offset(0);
        }];
    }
    return self;
}

@end
