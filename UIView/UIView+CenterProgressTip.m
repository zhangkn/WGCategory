//
//  UIView+ProgressTip.m
//  Comikon
//
//  Created by 7owen on 15/10/16.
//
//

#import "UIView+CenterProgressTip.h"
#import <objc/runtime.h>
#import "Masonry.h"

static void *UIViewCenterProgressLabelKey = &UIViewCenterProgressLabelKey;
static void *UIViewCenterProgressIndicatorKey = &UIViewCenterProgressIndicatorKey;

@implementation UIView (CenterProgressTip)

- (void)showCenterLoadingTip {
    [self showCenterLoadingTipWithStatus:NSLocalizedString(@"正在载入...", nil)];
}

- (void)showCenterLoadingTipWithStatus:(NSString*)status {
    UILabel *label = (UILabel*)objc_getAssociatedObject(self, UIViewCenterProgressLabelKey);
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView*)objc_getAssociatedObject(self, UIViewCenterProgressIndicatorKey);
    if (!label) {
        label = [UILabel new];
        objc_setAssociatedObject(self, UIViewCenterProgressLabelKey, label, OBJC_ASSOCIATION_RETAIN);
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self).offset(12.f);
        }];
    }
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        objc_setAssociatedObject(self, UIViewCenterProgressIndicatorKey, indicatorView, OBJC_ASSOCIATION_RETAIN);
        [self addSubview:indicatorView];
        [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(label.mas_left).offset(-4.f);
        }];
    }
   
    label.text = status;
    [indicatorView startAnimating];
}

- (void)dismissCenterLoadingTip {
    UILabel *label = (UILabel*)objc_getAssociatedObject(self, UIViewCenterProgressLabelKey);
    UIActivityIndicatorView *indicatorView = (UIActivityIndicatorView*)objc_getAssociatedObject(self, UIViewCenterProgressIndicatorKey);
    [label removeFromSuperview];
    [indicatorView removeFromSuperview];
    objc_setAssociatedObject(self, UIViewCenterProgressLabelKey, nil, OBJC_ASSOCIATION_RETAIN);
    objc_setAssociatedObject(self, UIViewCenterProgressIndicatorKey, nil, OBJC_ASSOCIATION_RETAIN);
}

@end