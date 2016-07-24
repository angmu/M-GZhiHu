//
//  MGDetailViewController.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/17.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface MGDetailViewController ()
{
    NSString *_imageStr;
    NSString *_imageSource;
    
    
    UIImageView *_headImageView;
    UILabel *_label;
    UILabel *_sourceLabel;
}

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation MGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 初始化导航栏
    [self setupNavBar];
    
    // 加载页面
    [self loadPageData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - 加载页面
- (void)loadPageData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/%ld", _storyId];
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSString *body = responseObject[@"body"];
        NSString *cssUrl = responseObject[@"css"][0];
        
        // 加载最上面图片
#warning 有待优化
        if (_headImageView == nil) {
            _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
            _headImageView.backgroundColor = [UIColor clearColor];
            _headImageView.contentMode = UIViewContentModeScaleAspectFill;
            _headImageView.clipsToBounds = YES;
            [_webView.scrollView addSubview:_headImageView];
            
        }
        _imageStr = responseObject[@"image"];
        _imageSource = [responseObject valueForKey:@"image_source"];
        
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_imageStr]];
        
        
        //创建label
        if (_label == nil) {
            _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH - 10 - 10, 60)];
        }
        
        _label.text = responseObject[@"title"];
        _label.font = [UIFont systemFontOfSize:20];
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 2;
        _label.backgroundColor = [UIColor clearColor];
        [_headImageView addSubview:_label];
        
        if (_sourceLabel == nil) {
            _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 180, 120, 20)];
        }
        
        _sourceLabel.text = _imageSource;
        
        _sourceLabel.font = [UIFont systemFontOfSize:10];
        _sourceLabel.textColor = [UIColor whiteColor];
        [_headImageView addSubview:_sourceLabel];
        
        
        NSString *htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" href=%@></head><body>%@</body></html>",cssUrl,body];
        
//        LxDBAnyVar(htmlString);
        [self.webView loadHTMLString:htmlString baseURL:nil];
        
    } failure:nil];
}


#pragma mark - 初始化导航栏
- (void)setupNavBar
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"icon_player_back"] forState:UIControlStateNormal];
    backButton.bounds = (CGRect){CGPointZero, [backButton currentImage].size};
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    // 设置状态栏背景
    UIView *statusBarView = [[UIView alloc] init];
    statusBarView.frame = [UIApplication sharedApplication].statusBarFrame;
    statusBarView.backgroundColor = MGColor(43, 48, 51);
    [self.view addSubview:statusBarView];
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
