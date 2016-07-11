//
//  MGContentCell.m
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGContentCell.h"
#import "UIImageView+WebCache.h"

@interface MGContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation MGContentCell
- (void)setStory:(MGStory *)story
{
    _story = story;
    
    self.contentLabel.text = story.title;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:[story.images lastObject]] placeholderImage:nil];
}

@end
