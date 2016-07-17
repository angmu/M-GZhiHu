//
//  MGContentViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGContentViewController.h"
#import <SDCycleScrollView.h>
#import <SWRevealViewController.h>
#import <MJRefresh.h>

#import "MGTopStory.h"
#import "MGStory.h"
#import "MGContentCell.h"
#import "MGDateTool.h"
#import "MGDetailViewController.h"


@interface MGContentViewController () <SDCycleScrollViewDelegate>

/** 滚动图片 */
@property (nonatomic, strong) SDCycleScrollView *scrollImageView;
/** 广告数据 */
@property (nonatomic, strong) NSArray *topStories;

/** 表格数据(组) */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/** 过去的某一天 */
@property (nonatomic, assign) NSInteger pastIndex;


@end

@implementation MGContentViewController
#pragma mark - 懒加载
- (NSMutableArray *)sectionArray
{
    if (!_sectionArray) {
        _sectionArray = [[NSMutableArray alloc] init];
    }
    return _sectionArray;
}


#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    self.view.backgroundColor = [UIColor grayColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 保证调用scrollViewDidScroll方法 --->>在viewWillAppear中做
//    [self.tableView setContentOffset:CGPointMake(0, 1)];
    LxDBAnyVar(self.tableView.contentOffset.y);
    
    [self loadData];
    
    // 集成刷新控件
    [self setupRefresh];

//    LxDBAnyVar(self.tableView.contentInset);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
    [self scrollViewDidScroll:self.tableView];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}


#pragma mark - 初始化
/**
 *  设置导航栏
 */
- (void)setupNavigationBar
{
    // 设置导航内容的颜色，title，左右item
//    self.navigationController.navigationBar.barTintColor = MGNavBarColor;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    // 隐藏导航栏分割线
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // revel控制器
    SWRevealViewController *revealVc = self.revealViewController;
    [self.view addGestureRecognizer:revealVc.panGestureRecognizer];
    revealVc.rearViewRevealWidth = 210;
    revealVc.bounceBackOnOverdraw = NO; // 拉到边界不弹回
    
    // 左边控制器Item
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Home_Icon"] style:UIBarButtonItemStylePlain target:revealVc action:@selector(revealToggle:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

#pragma mark - 集成刷新控件
- (void)setupRefresh
{
    // 上拉刷新
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

#pragma mark - 加载数据
- (void)loadData
{
    // 加载最前面的数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 获取首页照片轮播内容以及最新消息
    [manager GET:@"http://news-at.zhihu.com/api/4/news/latest" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 首页轮播数据
        self.topStories = [MGTopStory mj_objectArrayWithKeyValuesArray:responseObject[@"top_stories"]];
        
        // 加载第一组数据
        NSArray *stories = [MGStory mj_objectArrayWithKeyValuesArray:responseObject[@"stories"]];
        [self.sectionArray addObject:stories];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self setupScrollImageView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-- 加载失败");
    }];
}

/**
 *  加载更多数据
 */
- (void)loadMoreData
{
    // 加载更多数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 参数处理
    NSDate *requestDate = [MGDateTool getOldDateWithDays:self.pastIndex];
    
    NSString *paramStr = [MGDateTool getDateString:requestDate];
    LxDBAnyVar(requestDate);
    LxDBAnyVar(paramStr);
    
    NSString *urlStr = [NSString stringWithFormat:@"http://news.at.zhihu.com/api/4/news/before/%@",paramStr];
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        // 加载的数据
        NSArray *stories = [MGStory mj_objectArrayWithKeyValuesArray:responseObject[@"stories"]];
        [self.sectionArray addObject:stories];
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
        
        // 刷新表格
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        // 结束刷新
        [self.tableView.footer endRefreshing];
    }];
    
//    _pastIndex++;
    LxDBAnyVar(_pastIndex);
}


#pragma mark - 添加循环滚动图片
- (void)setupScrollImageView
{
    SDCycleScrollView *scrollImageView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, - 64, SCREEN_WIDTH, MGScrollImageH)];
    _scrollImageView = scrollImageView;
    
    // 设置SDCycleScrollView属性
    scrollImageView.autoScrollTimeInterval = 4;
    scrollImageView.delegate = self;
    
    scrollImageView.titleLabelHeight = 120;
    scrollImageView.titleLabelTextFont = [UIFont boldSystemFontOfSize:17.0];
    scrollImageView.titleLabelBackgroundColor = [UIColor clearColor];
    scrollImageView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    scrollImageView.dotColor = MGNavBarColor;
    
    // 设置SDCycleScrollView数据
    scrollImageView.imageURLStringsGroup = [self.topStories valueForKey:@"image"];
    scrollImageView.titlesGroup = [self.topStories valueForKey:@"title"];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MGScrollImageH - MGNavBarH)];
    [headerView addSubview:scrollImageView];
    
    self.tableView.tableHeaderView = headerView;
    
}


#pragma mark - UITableViewControllerDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sectionArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"contentCell";
    MGContentCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.设置cell的数据
    NSArray *stories = self.sectionArray[indexPath.section];
    cell.story = stories[indexPath.row];
    
    // 3.返回cell
    return cell;
}
#pragma mark - UITableViewDelegate
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
////    return self.sectionTitle;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSDate *sectionDate = [MGDateTool getOldDateWithDays:section];
    NSString *title = [MGDateTool getDateWeek:sectionDate];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    titleLabel.backgroundColor = MGNavBarColor;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 0 : 30;
}

#pragma mark 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *stories = self.sectionArray[indexPath.section];
    MGStory *story = stories[indexPath.row];
    // 详细界面
    [self performSegueWithIdentifier:@"mainContentSegue" sender:story];
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor *navBarColor = MGNavBarColor;
    
//    LxDBAnyVar(offsetY);
//    LxDBAnyVar(offsetY + MGNavBarH);
    
    CGFloat alpha = (offsetY+MGNavBarH) / (MGScrollImageH - MGNavBarH);
    if (alpha < 1.0) {
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[navBarColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:navBarColor];
    }
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    MGTopStory *topStory = self.topStories[index];
//    NSLog(@"你点击了……%zd",topStory.storyId);
    
    [self performSegueWithIdentifier:@"mainContentSegue" sender:topStory];
}

#pragma mark - 跳转之前调用,设置数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MGStory *story = (MGStory *)sender;
    MGDetailViewController *destinationVc = segue.destinationViewController;
    destinationVc.storyId = story.storyId;
}
@end
