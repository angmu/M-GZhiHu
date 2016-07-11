//
//  MGContentCell.h
//  MGZhiHu
//
//  Created by 穆良 on 16/6/29.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGStory.h"

@interface MGContentCell : UITableViewCell

/** cell的数据 */
@property (nonatomic, strong) MGStory *story;
@end
