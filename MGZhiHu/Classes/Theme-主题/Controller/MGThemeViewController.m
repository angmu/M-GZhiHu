//
//  MGThemeViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/19.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeViewController.h"
#import "MGToThemeContentCell.h"
#import "MGTheme.h"
#import "MGThemeContentViewController.h"

@interface MGThemeViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_themeArray; //> 主题数据源
}

/** 表格 */
@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end


@implementation MGThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self loadThemeData];
    
    self.tableView.backgroundColor = [UIColor blackColor];
}

- (void)loadThemeData
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [manager GET:@"http://news-at.zhihu.com/api/4/themes" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
            _themeArray = [MGTheme mj_objectArrayWithKeyValuesArray:responseObject[@"others"]];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            LxDBAnyVar(@"加载主题失败……");
        }];
    });
}

#pragma mark - 表格数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _themeArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *mainCellID = @"toMainContentCell";
    static NSString *themeCellID = @"toThemeContentCell";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellID];
        return cell;
    } else {
        MGToThemeContentCell *cell = [tableView dequeueReusableCellWithIdentifier:themeCellID];
        MGTheme *theme = _themeArray[indexPath.row-1];
        cell.themeTitleLabel.text = theme.name;
        return cell;
    }
}

#pragma mark - 表格代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 0) {
        
        MGTheme *theme = _themeArray[indexPath.row-1];
        [self performSegueWithIdentifier:@"toThemeContentSegue" sender:theme];
    }
}

#pragma mark - 给主题内容控制器传递数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toThemeContentSegue"]) {
        MGThemeContentViewController *themeContentVc = segue.destinationViewController.childViewControllers[0];
        
        MGTheme *theme = (MGTheme *)sender;
        themeContentVc.themeId = theme.themeId;
    }
}


@end
