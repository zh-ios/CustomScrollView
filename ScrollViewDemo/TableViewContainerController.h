//
//  TalbeViewContainerController.h
//  ScrollViewDemo
//
//  Created by hz on 2021/2/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewContainerController : UIViewController

@property (nonatomic, copy) void (^scrollDidScrollCallback)(UIScrollView *scrollView);

@end

NS_ASSUME_NONNULL_END
