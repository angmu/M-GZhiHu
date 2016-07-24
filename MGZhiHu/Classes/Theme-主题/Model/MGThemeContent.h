//
//  MGThemeContent.h
//  MGZhiHu
//
//  Created by 穆良 on 16/7/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MGStory, MGEditor;

@interface MGThemeContent : NSObject

@property (nonatomic, strong) NSArray<MGStory *> *stories; //!< 主题故事
@property (nonatomic, strong) NSArray<MGEditor *> *editors; //!< 作者信息,可能不止一个作者
@property (nonatomic, copy) NSString *name; //!< 主题名字
@property (nonatomic, copy) NSString *image; //!< 背景图片缩小版本,用来当做导航栏背景图片
@property (nonatomic, copy) NSString *image_source; //!< 图像版权信息
@property (nonatomic, copy) NSString *ThemeDescription; //!< 主题描述

@property (nonatomic, copy) NSString *background; //!< 主题日报背景图片
@property (nonatomic, assign) NSInteger color; //!< 主题颜色,作用未知

@end


//@interface MGThemeStory : NSObject 
//
//@property (nonatomic, assign) NSInteger storyId; //!< 故事Id
//@property (nonatomic, copy) NSString *title; //!< 故事标题
//@property (nonatomic, assign) NSInteger type; //!< 故事类型,作用未知
//@property (nonatomic, strong) NSArray<NSString *> *images; //!< 图片数组,可能为空,可能为一张,也可能为多张
//
//@end

@interface MGEditor : NSObject

@property (nonatomic, assign) NSInteger editorId; //!< 作者Id
@property (nonatomic, copy) NSString *name; //!< 作者个人介绍
@property (nonatomic, copy) NSString *avatar; //!< 作者头像
@property (nonatomic, copy) NSString *url; //!< 作者之乎日报主页s
@property (nonatomic, copy) NSString *bio; //!< 作者自我介绍

@end