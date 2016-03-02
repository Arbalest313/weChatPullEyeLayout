//
//  ViewController.m
//  weChatPullEyeLayout
//
//  Created by huangyuan on 2/18/16.
//  Copyright © 2016 com.yuan.WeChatPull. All rights reserved.
//

#import "ViewController.h"
#import "EyeLayoutView.h"
#import "EyeLayoutView2.h"
#define headerHeight 65*2
@interface ViewController () <UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)EyeLayoutView * eyeLayout;
@property (nonatomic, strong)EyeLayoutView2 * wink;

@property (nonatomic, strong)CADisplayLink * displaylink;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView reloadData];
    [self.view addSubview:self.eyeLayout];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseIdentifer = @"reusetable";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:reuseIdentifer];
    };
    cell.textLabel.text = @"test";
    return cell;
}

#pragma mark : scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -scrollView.contentInset.top
        && scrollView.contentOffset.y < 0)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y == 0)//到0说明headerView已经在tableView最上方，不需要再修改了
    {
        scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    [self.eyeLayout animationWiht:scrollView.contentOffset.y];
    [self resetEyeLayouFrame:scrollView.contentOffset.y];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.displaylink.paused = NO;
        [UIView animateWithDuration:.8f animations:^{
            scrollView.contentInset = UIEdgeInsetsZero;
            scrollView.contentOffset = CGPointZero;
        } completion:^(BOOL finished) {
            if (finished) {
                self.displaylink.paused = YES;
            }
        }];
    });

}



- (void)resetEyeLayouFrame:(CGFloat) y {
     _eyeLayout.frame =  CGRectMake(0, -headerHeight - y, CGRectGetWidth(self.view.frame), headerHeight);
}

- (void)animationUpdateContent {
    [self.eyeLayout animationWiht:_tableView.contentOffset.y];
    [self resetEyeLayouFrame:_tableView.contentOffset.y];

}

#pragma  mark : getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.frame = self.view.bounds;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView.superview addSubview:self.eyeLayout];
        [_tableView addSubview:self.wink];
        [_tableView bringSubviewToFront:_eyeLayout];
//        [_tableView bringSubviewToFront:self.wink];

        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (CADisplayLink *)displaylink {
    if (!_displaylink) {
        _displaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationUpdateContent)];
        [_displaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
    return _displaylink;
}

- (EyeLayoutView *)eyeLayout {
    if (!_eyeLayout) {
        _eyeLayout = [[EyeLayoutView alloc] initWithFrame: CGRectMake(0, -headerHeight, CGRectGetWidth(self.view.frame), headerHeight)];
    }
    return _eyeLayout;
}

- (EyeLayoutView2 *)wink {
    if (!_wink) {
//        _wink = [[EyeLayoutView2 alloc] initWithFrame: CGRectMake(CGRectGetWidth(self.view.bounds)/8, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.frame)/8, CGRectGetWidth(self.view.bounds)/8)];
        _wink = [[EyeLayoutView2 alloc] initWithFrame: CGRectMake(CGRectGetWidth(self.view.bounds)/8, CGRectGetHeight(self.view.bounds)/2, CGRectGetWidth(self.view.frame)/4, CGRectGetWidth(self.view.bounds)/4)];

    }
    return _wink;
}

@end
