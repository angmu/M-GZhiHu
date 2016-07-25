//
//  MGSettingCell.h
//  MGZhiHu
//
//  Created by 穆良 on 16/7/25.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGSettingCell : UITableViewCell
/** 标题 */
@property (nonatomic, weak) IBOutlet UILabel *cellTitleLabel;
/** 开关 */
@property (nonatomic, weak) IBOutlet UISwitch *cellSwitch;

@end
