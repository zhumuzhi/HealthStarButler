//
//  FSTableView.m
//  FangShengyun
//
//  Created by mac on 2018/6/19.
//  Copyright © 2018年 http://www.xinfangsheng.com. All rights reserved.
//

#import "FSTableView.h"

@implementation FSTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self == [super initWithFrame:frame style:style]) {
        self.isHiddenLine = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return self;
}
- (void)setIsHiddenLine:(BOOL)isHiddenLine {
    if (!isHiddenLine) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

- (void)addHeaderWithTarget:(id)target action:(SEL)action {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    //     Hide the time
    //    header.lastUpdatedTimeLabel.hidden = NO;
    //    header.stateLabel.hidden = YES;
    self.mj_header = header;
}
- (void)headerBeginRefreshing {
    [self.mj_header beginRefreshing];
    
}
- (void)headerEndRefreshing {
    [self.mj_header endRefreshing];
}
- (void)addFooterWithTarget:(id)target action:(SEL)action {
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingTarget:target refreshingAction:action];
    // 禁止自动加载
    footer.automaticallyRefresh = YES;
    self.mj_footer = footer;
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}
- (void)footerBeginRefreshing {
    [self.mj_footer beginRefreshing];
}
- (void)footerEndRefreshing {
    [self.mj_footer endRefreshing];
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
