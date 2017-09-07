//
//  NoDataView.m
//  KingNoData
//
//  Created by wsk on 2017/9/7.
//  Copyright © 2017年 wsk. All rights reserved.
//

#import "NoDataView.h"

@implementation NoDataView

+ (instancetype)instacneView {
    NoDataView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([NoDataView class]) owner:nil options:nil].lastObject;
    [view addGuesture];
    return view;
}

- (void)addGuesture {
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
}

- (void)tapAction {
    if (self.clickedNoDataView) {
        self.clickedNoDataView(self);
    }

}
@end
