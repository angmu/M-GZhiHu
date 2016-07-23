//
//  MGThemeContentViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/23.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeContentViewController.h"

@interface MGThemeContentViewController ()

@end

@implementation MGThemeContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // chushia
    
//    self.title =
    [self setupNavBar];
}

#pragma mark - 初始化导航控制栏
- (void)setupNavBar
{
    // 导航栏颜色
    [self.navigationController.navigationBar lt_setBackgroundColor:MGNavBarColor];
//    self.navigationController.navigationBar.barTintColor = MGNavBarColor;
    
    // 添加手势
    SWRevealViewController *revealVc = self.revealViewController;
    [self.view addGestureRecognizer:revealVc.panGestureRecognizer];
    
    // item都是白色的
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Dark_News_Arrow"] style:UIBarButtonItemStylePlain target:revealVc action:@selector(revealToggle:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Dark_Management_Add"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
}

@end
