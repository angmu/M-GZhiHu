//
//  MGTheme.h
//  MGZhiHu
//
//  Created by 穆良 on 16/7/23.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGTheme : NSObject

/** 主题名字 */
@property (nonatomic, copy) NSString *name;

/** 主题内容 */
@property (nonatomic, assign) NSInteger themeId;

/** 主题描述 */
@property (nonatomic, copy) NSString *themeDescription;

/** 详细内容显示的图片地址 */
@property (nonatomic, copy) NSString *thumbnail;

/** 颜色,没什么用 */
@property (nonatomic, assign) NSInteger color;
@end
