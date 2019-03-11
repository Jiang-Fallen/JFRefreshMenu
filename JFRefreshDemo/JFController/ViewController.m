//
//  ViewController.m
//  RefreshDemo
//
//  Created by Mr_J on 16/3/5.
//  Copyright © 2016年 Mr_J. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+JFRefresh.h"
#import "JFTableViewCell.h"

static NSString *cellIndetifier = @"JFTableViewCellIdentifier";
@interface ViewController () <UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) NSMutableArray *imageNamedArray;
@property (nonatomic, strong) NSMutableArray *titleNamedArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
}

- (void)initSubViews{
    self.contentTableView.estimatedRowHeight = 44;
    self.contentTableView.rowHeight = UITableViewAutomaticDimension;
    [self.contentTableView registerNib:[UINib nibWithNibName:@"JFTableViewCell" bundle:nil]
                forCellReuseIdentifier:cellIndetifier];
    
    __weak typeof(self) weakSelf = self;
    /* 
     customControl Block块内可定制组件内容
     如果不需要定制内容则可以直接使用下面函数
     - addHeaderWithAction:
    */
    [self.contentTableView addHeaderWithAction:^(NSInteger index) {
        [weakSelf action:index];
    } customControl:^(JFRefreshControl *control) {
        [weakSelf customRefreshControl:control];
    }];
}

- (void)customRefreshControl:(JFRefreshControl *)control{
    //常规状态下Items图片数组
    control.normalItems = @[@"tab_home_n", @"tab_inspiration_n", @"tab_purchase_n"];
    //常规状态下Items图片数组
    control.highlightItems = @[@"tab_home_s", @"tab_inspiration_s", @"tab_purchase_s"];
    //头视图基准高度 default == 64
    control.baseHeight = 64;
    //视图开始位置 default == 0, 如果需要从TableView顶部开始，则设置为tableView Origin.Y
    control.show_MIN_Y = 0;
    //从矩阵一边的直线到贝塞尔弧线开始变化的值 default == 15
    control.startLocation_Y = 20;
    //顶部变换图形的阴影透明度值 default == 0, value 0 - 1
    control.topShadowAlpha = 0.4;
}

#pragma mark - set get
- (NSMutableArray *)imageNamedArray{
    if (!_imageNamedArray) {
        _imageNamedArray = [NSMutableArray arrayWithCapacity:40];
        NSString *imageNamePrefix = @"ComicStoreList";
        for (int i = 0; i < 40; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%02d", imageNamePrefix, arc4random()% 10 + 1];
            [_imageNamedArray addObject:imageName];
        }
    }
    return _imageNamedArray;
}

- (NSMutableArray *)titleNamedArray{
    if (!_titleNamedArray) {
        _titleNamedArray = [NSMutableArray arrayWithCapacity:40];
        for (int i = 0; i < 40; i++) {
            int sum = arc4random()% 100;
            NSMutableString *titleMutableString = [NSMutableString string];
            for (int j = 0; j < sum; j++) {
                [titleMutableString appendString:[NSString stringWithFormat:@"%d", arc4random()% 10]];
            }
            [_titleNamedArray addObject:titleMutableString];
        }
    }
    return _titleNamedArray;
}

#pragma mark - delegate datasource

- (UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _contentTableView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
        _contentTableView.dataSource = self;
        _contentTableView.rowHeight = 44;
        _contentTableView.alwaysBounceVertical = YES;
        _contentTableView.backgroundColor = [UIColor blueColor];
        _contentTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:_contentTableView];
    }
    return _contentTableView;
}

- (void)action:(NSInteger)index{
    NSString *titleString = [NSString stringWithFormat:@"选中了第%ld项", index + 1];
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:titleString
                                                       message:nil
                                                      delegate:nil
                                             cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.imageNamedArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier forIndexPath:indexPath];
    cell.contentImageView.image = [UIImage imageNamed:self.imageNamedArray[indexPath.row]];
    cell.discriptionLabel.text = self.titleNamedArray[indexPath.row];
    return cell;
}

@end
