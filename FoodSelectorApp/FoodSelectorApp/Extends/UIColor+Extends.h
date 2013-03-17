//
//  UIColor+Extends.h
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kColorWithRGB(r, g, b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define kColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define kColorWithValue(v)         [UIColor colorWithRed:(((v) >> 16) & 0xff)/255.0f green:(((v) >> 8) & 0xff)/255.0f blue:((v) & 0xff)/255.0f alpha:1]


// iphone/ipad不支持十六进制的颜色表示，对UIColor进行扩展
@interface UIColor(Extends)

// 将十六进制颜色的字符串转化为复合iphone/ipad的颜色
// 字符串为"FFFFFF"
+ (UIColor *)hexChangeFloat:(NSString *) hexColor;

@end
