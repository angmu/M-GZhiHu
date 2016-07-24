//
//  MGThemeContent.m
//  MGZhiHu
//
//  Created by 穆良 on 16/7/24.
//  Copyright © 2016年 穆良. All rights reserved.
//

#import "MGThemeContent.h"
#import "MGStory.h"

@implementation MGThemeContent

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
//             @"stories" : [MGThemeStory class],
             @"stories" : [MGStory class],
             @"editors" : [MGEditor class]
            };
}

+ (NSDictionary*)mj_replacedKeyFromPropertyName {
    
    return @{
             @"ThemeDescription": @"description"
             };
}

@end

//@implementation MGThemeStory
//
//+ (NSDictionary*)mj_replacedKeyFromPropertyName{
//    
//    return @{
//             @"storyId":@"id"
//             };
//}
//
//@end


@implementation MGEditor

+ (NSDictionary*)mj_replacedKeyFromPropertyName{
    
    return @{
             @"editorId":@"id"
             };
}

@end
