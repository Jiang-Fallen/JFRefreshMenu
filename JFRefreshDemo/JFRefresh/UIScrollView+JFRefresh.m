//
//  UIScrollView+JFRefresh.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "UIScrollView+JFRefresh.h"
#import <objc/runtime.h>

NSString * const _refreshControl = @"refreshControl";
@implementation UIScrollView (JFRefresh)

- (void)addHeaderWithAction:(void (^)(NSInteger))action{
    [self.jf_refreshControl removeFromScrollView];
    
    self.jf_refreshControl = [[JFRefreshControl alloc]initWithScrollView:self];
    self.jf_refreshControl.actionOfIndex = action;
}

- (void)addHeaderWithAction:(void (^)(NSInteger))action customControl:(void (^)(JFRefreshControl *))opration{
    [self addHeaderWithAction:action];
    opration(self.jf_refreshControl);
}

- (JFRefreshControl *)jf_refreshControl{
    return (JFRefreshControl *)objc_getAssociatedObject(self, &_refreshControl);
}

- (void)setJf_refreshControl:(JFRefreshControl *)jf_refreshControl{
    objc_setAssociatedObject(self, &_refreshControl, jf_refreshControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
