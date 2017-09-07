//
//  UITableView+NoData.m
//  KingNoData
//
//  Created by wsk on 2017/9/7.
//  Copyright © 2017年 wsk. All rights reserved.
//

#import "UITableView+NoData.h"
#import <objc/runtime.h>
#import "NoDataView.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

@implementation UITableView (NoData)

//方法替换
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        //原有方法
        Method originalMethod = class_getInstanceMethod(class, @selector(reloadData));
        //替换原有方法的新方法
        Method swizzledMethod = class_getInstanceMethod(class, @selector(mineReloadData));
        BOOL didAddMethod = class_addMethod(class,@selector(reloadData),
                                            method_getImplementation(swizzledMethod),
                                            method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class,@selector(mineReloadData),
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

//查看是否显示空数据视图
- (void)checkIsShowEmpty {
        NSInteger cellCount = [self numberOfRowsInSection:0];
        if (cellCount) {
            //不为空
            [self removeNoDataView];
        }else {
            [self showNoDataView];
        }
    
}

- (void)showNoDataView {
        NoDataView *noDataView = [NoDataView instacneView];
        [noDataView setClickedNoDataView:^(NoDataView *view){
            NSLog(@"xxixiix");
        }];
        noDataView.frame = CGRectMake(0, (self.bounds.size.height - 300)/2, SCREEN_WIDTH, 300);
        [self addSubview:noDataView];
}

- (void)removeNoDataView {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[NoDataView class]]) {
            [view removeFromSuperview];
        }
    }
}


- (void)mineReloadData {
    [self mineReloadData];
    [self checkIsShowEmpty];
}



@end
