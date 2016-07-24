//
//  MGThemeImageCell.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeImageCell.h"

@interface MGThemeImageCell ()
/** 标题文本框 */
@property (nonatomic, weak) IBOutlet UILabel *themeTitleLabel;

/** 图片 */
@property (nonatomic, weak) IBOutlet UIImageView *themeImageView;

@end

@implementation MGThemeImageCell

- (void)setStory:(MGStory *)story
{
    _story = story;
    
    _themeTitleLabel.text = story.title;
    [_themeImageView sd_setImageWithURL:[NSURL URLWithString:story.images[0]]];
}



@end
