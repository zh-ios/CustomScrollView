//
//  TalbeViewContainerController.m
//  ScrollViewDemo
//
//  Created by hz on 2021/2/24.
//

#import "TableViewContainerController.h"
#import "CustomTableView.h"


@interface TableViewContainerController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CustomTableView *tableView;

@end

@implementation TableViewContainerController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 更新ui ，header是悬停在cell上的， 需要减去底部tableView的header的高度
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[CustomTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"----->%@",@(indexPath.row)];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollDidScrollCallback) {
        self.scrollDidScrollCallback(scrollView);
    }
}


@end
