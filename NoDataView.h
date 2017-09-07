//
//  NoDataView.h
//  KingNoData
//
//  Created by wsk on 2017/9/7.
//  Copyright © 2017年 wsk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView
+ (instancetype)instacneView;
@property (nonatomic, copy) void (^clickedNoDataView)(NoDataView *view);
@end
