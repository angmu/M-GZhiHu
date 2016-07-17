//
//  MGDetailViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGDetailViewController.h"
#import <UINavigationBar+Awesome.h>

@interface MGDetailViewController ()

@end

@implementation MGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupNavBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar lt_reset];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_player_back"] forState:UIControlStateNormal];
    backButton.bounds = (CGRect){CGPointZero, [backButton currentImage].size};
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
}

- (void)backAction
{
    NSLog(@"%s", __func__);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
