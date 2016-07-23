//
//  MGTheme.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/23.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGTheme.h"

@implementation MGTheme

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{ @"themeId": @"id",
              @"themeDescription" : @"description",
             };
}

@end
