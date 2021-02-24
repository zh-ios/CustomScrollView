//
//  CustomTableView.m
//  ScrollViewDemo
//
//  Created by hz on 2021/2/24.
//

#import "CustomTableView.h"

@implementation CustomTableView



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 如果是container 屏蔽手势，解决上下滑动时同时可以左右滑动的问题
    if (otherGestureRecognizer.view.tag == 123456) {
        return NO;
    }
    return YES;
}


@end
