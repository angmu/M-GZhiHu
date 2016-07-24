//
//  MGThemeContentViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/23.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeContentViewController.h"
#import "MGThemeContent.h"
#import "MGThemeImageCell.h"
#import "MGThemeNoImageCell.h"
#import "MGThemeEditorCell.h"
#import "MGDetailViewController.h"

#import "MGStory.h"

@interface MGThemeContentViewController ()
{
    MGThemeContent *_themeContent;
    NSArray *_themeStories;
    MGEditor *_editor;
}

@end

@implementation MGThemeContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // chushia
    
    [self setupNavBar];
    
    // 加载数据
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:MGNavBarColor];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark - 初始化导航控制栏
- (void)setupNavBar
{
    // 导航栏颜色
//    [self.navigationController.navigationBar lt_setBackgroundColor:MGNavBarColor];
//    self.navigationController.navigationBar.barTintColor = MGNavBarColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    // 添加手势
    SWRevealViewController *revealVc = self.revealViewController;
    [self.view addGestureRecognizer:revealVc.panGestureRecognizer];
    [self.view addGestureRecognizer:revealVc.tapGestureRecognizer];
    
    // item都是白色的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Dark_News_Arrow"] style:UIBarButtonItemStylePlain target:revealVc action:@selector(revealToggle:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Dark_Management_Add"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - 加载数据
- (void)loadData
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *urlStr = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/theme/%ld", _themeId];
        
        [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            
            _themeContent = [MGThemeContent mj_objectWithKeyValues:responseObject];
            _themeStories = _themeContent.stories;
            _editor = _themeContent.editors[0];
            self.title = _themeContent.name;
            
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            LxDBAnyVar(@"加载数据失败");
        }];
    });
}


#pragma mark - 表格数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ?_themeStories.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *themeImageCellID = @"themeImageCell";
    static NSString *themeNoImageCellID = @"themeNoImageCell";
    static NSString *themeEditorCellID = @"themeEditorCell";
    
    if (indexPath.section) {
        MGStory *story = _themeStories[indexPath.row];
        
        if (story.images.count) {
            MGThemeImageCell *cell = [tableView dequeueReusableCellWithIdentifier:themeImageCellID];
            cell.story = story;
            return cell;
        } else {
            MGThemeNoImageCell *cell = [tableView dequeueReusableCellWithIdentifier:themeNoImageCellID];
            cell.story = story;
            return cell;
        }
    } else {
        
        MGThemeEditorCell *cell = [tableView dequeueReusableCellWithIdentifier:themeEditorCellID];
        cell.editor = _editor;
        return cell;
    }
}

#pragma mark - 表格代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section ?80 :40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!indexPath.section)  return;
    
    MGStory *themeStory = _themeStories[indexPath.row];
    [self performSegueWithIdentifier:@"themeToMainContent" sender:themeStory];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MGDetailViewController class]]) {
        MGDetailViewController *detail = segue.destinationViewController;
        MGStory *themeStory = sender;
        detail.storyId = themeStory.storyId;
    }
}
@end
