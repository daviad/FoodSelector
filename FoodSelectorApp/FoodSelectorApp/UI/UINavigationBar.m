//
//  UINavigationBar.m
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "UINavigationBar.h"

@implementation UINavigationBar (CustomImage)

- (void)drawRect:(CGRect)rect
{

    UIImage *image = [UIImage imageNamed:@"nav_bgView"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	
}





/*
 float version = [[[UIDevice currentDevice] systemVersion] floatValue];
 UIImage *backgroundImage = [UIImage imageNamed:@"myBackgroundImage.png"];
 if (version >= 5.0) {
 [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
 }
 else
 {
 [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:backgroundImage] autorelease] atIndex:1];
 }
*/
@end
