//
//  MGContentViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGContentViewController.h"
#import <SDCycleScrollView.h>
#import <UINavigationBar+Awesome.h>
#import <SWRevealViewController.h>


#import "MGTopStory.h"


@interface MGContentViewController () <SDCycleScrollViewDelegate>

/** 滚动图片 */
@property (nonatomic, strong) SDCycleScrollView *scrollImageView;
/** 最顶部图片 */
@property (nonatomic, strong) NSArray *topStories;

@end

@implementation MGContentViewController
#pragma mark - 懒加载



#pragma mark - 控制器方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavigationBar];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 保证调用scrollViewDidScroll方法
    [self.tableView setContentOffset:CGPointMake(0, 1)];
    LxDBAnyVar(self.tableView.contentOffset.y);
    
    
    // 集成刷新控件
    [self setupRefresh];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 初始化
/**
 *  设置导航栏
 */
- (void)setupNavigationBar
{
    // 设置导航内容的颜色，title，左右item
    self.navigationController.navigationBar.barTintColor = MGNavBarColor;
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
        
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self setupScrollImageView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"-- 加载失败");
    }];
    
}


#pragma mark - 添加循环滚动图片
- (void)setupScrollImageView
{
    self.tableView.tableHeaderView = self.scrollImageView;
    
}

- (SDCycleScrollView *)scrollImageView
{
    if (_scrollImageView == nil) {
        _scrollImageView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MGScrollImageH)];
        
        // 设置SDCycleScrollView属性
        _scrollImageView.autoScrollTimeInterval = 4;
        _scrollImageView.delegate = self;
        
        _scrollImageView.titleLabelHeight = 120;
        _scrollImageView.titleLabelTextFont = [UIFont boldSystemFontOfSize:17.0];
        _scrollImageView.titleLabelBackgroundColor = [UIColor clearColor];
    
        // 设置SDCycleScrollView数据
        _scrollImageView.imageURLStringsGroup = [self.topStories valueForKey:@"image"];
        _scrollImageView.titlesGroup = [self.topStories valueForKey:@"title"];
        
//        LxDBAnyVar([self.topStories valueForKey:@"image"]);
        
    }
    
    return _scrollImageView;
}





#pragma mark - UITableViewControllerDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"mainContentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
//        LxDBAnyVar(@"cell为nil");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    // 2.设置cell的数据
    
    // 3.返回cell
    return cell;
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor *navBarColor = MGNavBarColor;
    
    CGFloat alpha = offsetY / (MGScrollImageH - MGNavBarH);
    if (alpha < 1.0) {
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[navBarColor colorWithAlphaComponent:alpha]];
    }
    LxDBAnyVar(offsetY);
    LxDBAnyVar(alpha);
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    MGTopStory *topStory = self.topStories[index];
    NSLog(@"你点击了……%zd",topStory.storyId);
}



@end
