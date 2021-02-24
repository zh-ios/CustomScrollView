//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by hz on 2021/2/24.
//

#import "ViewController.h"
#import "CustomTableView.h"
#import "TableViewContainerController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CustomTableView *tableView;
@property (nonatomic, strong) UIScrollView *container;

@property (nonatomic, assign) BOOL shouldSuperTaleViewScroll;
@property (nonatomic, assign) BOOL shouldSubTalbeViewScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    tableHeaderView.backgroundColor = [UIColor lightGrayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:tableHeaderView.bounds];
    [tableHeaderView addSubview:label];
    label.text = @"这是tableViewHeader";

    self.tableView = [[CustomTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.rowHeight = self.tableView.frame.size.height;
    self.shouldSuperTaleViewScroll = YES;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (!self.container) {
        self.container = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.tableView.rowHeight)];
        self.container.bounces = NO;
        self.container.tag = 123456;
        [cell.contentView addSubview:self.container];
        self.container.pagingEnabled = YES;
        [self addTableView];
        [self.container setContentSize:CGSizeMake(self.view.frame.size.width*2, 0)];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    sectionHeader.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:sectionHeader.bounds];
    [sectionHeader addSubview:label];
    label.text = @"这是sectionHeader";
    return  sectionHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat maxoffsetY = self.tableView.tableHeaderView.frame.size.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"-----%.2f", offsetY);
    if (offsetY>=maxoffsetY) {
        self.shouldSuperTaleViewScroll = NO;
        self.shouldSubTalbeViewScroll = YES;
        [scrollView setContentOffset:CGPointMake(0, maxoffsetY)];
    } else {
        if (self.shouldSuperTaleViewScroll == NO) {
            scrollView.contentOffset = CGPointMake(0, maxoffsetY);
        }
    }
}

- (void)addTableView {
    // container 里可以添加多个子view ，以实现左右滚动的效果
    TableViewContainerController *t1 = [[TableViewContainerController alloc] init];
    [self addChildViewController:t1];
    t1.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.container.frame.size.height);
    [self.container addSubview:t1.view];
    __weak typeof(self)weakSelf = self;
    t1.scrollDidScrollCallback = ^(UIScrollView * _Nonnull scrollView) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY<=0) {
            strongSelf.shouldSubTalbeViewScroll = NO;
            strongSelf.shouldSuperTaleViewScroll = YES;
        }
        if (!strongSelf.shouldSubTalbeViewScroll) {
            [scrollView setContentOffset:CGPointZero];
        }
    };
    
    
    TableViewContainerController *t2 = [[TableViewContainerController alloc] init];
    [self addChildViewController:t2];
    t2.view.frame = CGRectMake(self.view.frame.size.width*1, 0, self.view.frame.size.width, self.container.frame.size.height);
    [self.container addSubview:t2.view];
    t2.scrollDidScrollCallback = ^(UIScrollView * _Nonnull scrollView) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY<=0) {
            strongSelf.shouldSubTalbeViewScroll = NO;
            strongSelf.shouldSuperTaleViewScroll = YES;
        }
        if (!strongSelf.shouldSubTalbeViewScroll) {
            [scrollView setContentOffset:CGPointZero];
        }
    };
}

@end
