//
//  MGThemeNoImageCell.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeNoImageCell.h"

@interface MGThemeNoImageCell ()

/** 标题文本框 */
@property (nonatomic, weak) IBOutlet UILabel *themeTitleLabel;

@end

@implementation MGThemeNoImageCell

- (void)setStory:(MGStory *)story
{
    _story = story;
    
    _themeTitleLabel.text = story.title;
}

@end
