//
//  MGDateTool.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/11.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGDateTool.h"

@interface MGDateTool ()
/** 当前时间 */
@property (nonatomic, strong) NSDate *now;

@end

@implementation MGDateTool


//-(NSArray *)loadDate:(NSDate *)now1
//{
//    
//}
+ (NSString *)getDateWeek:(NSDate *)date
{
    NSInteger year,month,day ,week;
    NSDateComponents *comps = [self componentsWithDate:date];
    
    year = [comps year];
    month = [comps month];
    day = [comps day];
    week = [comps weekday];
    
    NSString *weekStr = nil;
    if(week==1)
    {
        weekStr =@"星期天";
    }else if(week==2){
        weekStr=@"星期一";
        
    }else if(week==3){
        weekStr=@"星期二";
        
    }else if(week==4){
        weekStr=@"星期三";
        
    }else if(week==5){
        weekStr=@"星期四";
        
    }else if(week==6){
        weekStr=@"星期五";
        
    }else if(week==7){
        weekStr=@"星期六";
    }

    NSString *string = [NSString stringWithFormat:@"%zd月%zd日 %@",month,day,weekStr];
    return string;
}

+ (NSString *)getDateString:(NSDate *)date
{
    NSInteger year,month,day;
    
    NSDateComponents *comps = [self componentsWithDate:date];
    
    year = [comps year];
    month = [comps month];
    day = [comps day];
    
    NSString *string = [NSString stringWithFormat:@"%.4zd%.2zd%.2zd",year,month,day];
    return string;
}

+ (NSDateComponents *)componentsWithDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    return [calendar components:unitFlags fromDate:date];
}


/**
 *  前几天的日期
 *
 *  @param days 天数
 *
 *  @return 那天的日前
 */
+ (NSDate *)getOldDateWithDays:(NSInteger)days
{
    NSDate *old = [NSDate dateWithTimeIntervalSinceNow:-(days * 24 * 3600)];
    return old;
}

@end
