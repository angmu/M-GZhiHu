//
//  MGThemeEditorCell.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeEditorCell.h"

@interface MGThemeEditorCell ()

/** 名字 */
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
/** 描述 */
@property (nonatomic, weak) IBOutlet UILabel *bioLabel;
/** 图标 */
@property (nonatomic, weak) IBOutlet UIImageView *avatarImageView;

@end

@implementation MGThemeEditorCell

- (void)setEditor:(MGEditor *)editor
{
    _editor = editor;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:editor.avatar] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.avatarImageView.image = [image circleImage];
    }];
    self.nameLabel.text = editor.name;
    self.bioLabel.text = editor.bio;
}

@end
