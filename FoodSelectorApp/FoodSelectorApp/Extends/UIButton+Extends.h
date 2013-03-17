//
//  UIButton+Extends.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-16.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>


#pragma mark - UIButton + Loocha

#define kLoochaStdBtnHeight 32.5

extern NSString *const kBtnCyanBgImageName;
extern NSString *const kBtnOrangeBgImageName;

@interface UIButton (Loocha)

+ (id)loochaStdButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundImageName:(NSString *)backgroundImageName;

+ (id)loochaStdButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName;

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing;

@end