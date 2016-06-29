//
//  MGStory.h
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGStory : NSObject

/**
 *  storyId
 */
@property (nonatomic, assign) NSInteger storyId;

/**
 *  故事标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  故事类型,不知道有什么用
 */
@property (nonatomic, assign) NSInteger type;

/**
 *  故事图片地址,数组类型
 */
@property (nonatomic, strong) NSArray<NSString *> *images;

/**
 *  没什么用
 */
@property (nonatomic, copy) NSString *ga_prefix;

@end
