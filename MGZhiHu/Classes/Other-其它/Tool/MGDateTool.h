//
//  MGDateTool.h
//  MGZhiHu
//
//  Created by 穆良 on 16/7/11.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGDateTool : NSObject
/** 前几天的日期 */
+ (NSDate *)getOldDateWithDays:(NSInteger)days;

/** 有星期的日期个数 */
+ (NSString *)getDateWeek:(NSDate *)date;

/** 日期转换成字符串 */
+ (NSString *)getDateString:(NSDate *)date;

@end
