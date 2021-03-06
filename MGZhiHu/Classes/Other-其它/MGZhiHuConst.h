//
//  MGZhiHuConst.h
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#ifndef MGZhiHuConst_h
#define MGZhiHuConst_h


/** 下划线指示器默认高度 */
//static CGFloat const MGUnderLineH = 2;
///** 标题栏 默认高度 */
//static CGFloat const MGTitleScrollViewH = 40;
///** 标题默认间距 */
//static CGFloat const MGTitleMargin = 20;

/** ID -> pageViewID */
//static NSString *const pageViewID = @"MGPageViewCell";

/** 循环滚动图片高度 */
static CGFloat const MGScrollImageH = 220;
/** 导航栏高度 */
static CGFloat const MGNavBarH = 64;


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
/** 标题栏默认字体 */
#define MGTitleFont [UIFont systemFontOfSize:15]


#define MGColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define MGColorRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// 获取随机色
#define MGRandomColor MGColor(arc4random_uniform(256),  arc4random_uniform(256), arc4random_uniform(256)]

#define MGNavBarColor MGColor(47, 185, 254)

#define LRViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]


#endif /* MGZhiHuConst_h */
