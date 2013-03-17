//
//  UIButton+Extends.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-16.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "UIButton+Extends.h"

#pragma mark - UIButton + Loocha

NSString *const kBtnCyanBgImageName =  @"common_btn_cyan";
NSString *const kBtnOrangeBgImageName = @"common_btn_orange";

@implementation UIButton (Loocha)

+ (id)loochaStdButtonWithFrame:(CGRect)frame title:(NSString *)title backgroundImageName:(NSString *)backgroundImageName
{
    UIButton *stdBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    stdBtn.frame = frame;
    stdBtn.backgroundColor = [UIColor clearColor];
    [stdBtn setTitle:title forState:UIControlStateNormal];
    [stdBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIImage *image = [UIImage imageNamed:backgroundImageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [stdBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:[backgroundImageName stringByAppendingString:@"_touch"]];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [stdBtn setBackgroundImage:image forState:UIControlStateHighlighted];
    return stdBtn;
}

+ (id)loochaStdButtonWithFrame:(CGRect)frame imageName:(NSString *)imageName
{
    UIButton *stdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    stdBtn.frame = frame;
    stdBtn.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [stdBtn setImage:image forState:UIControlStateNormal];
    
    image = [UIImage imageNamed:[imageName stringByAppendingString:@"_touch"]];
    image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    [stdBtn setImage:image forState:UIControlStateHighlighted];
    return stdBtn;
}

- (void)centerImageAndTitleWithSpacing:(CGFloat)spacing
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
}

@end


