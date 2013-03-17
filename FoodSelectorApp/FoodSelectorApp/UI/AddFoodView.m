//
//  AddFoodView.m
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "AddFoodView.h"
#import "UIColor+Extends.h"
@implementation AddFoodView
@synthesize foodFiled;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(float)LayOutContentView:(UIView *)view
{
    foodFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 13, 200, 40)];
    foodFiled.center = CGPointMake(self.center.x-20, foodFiled.center.y);
    foodFiled.backgroundColor = [UIColor whiteColor];
    foodFiled.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    foodFiled.borderStyle =UITextBorderStyleLine;
    [view addSubview:foodFiled];
    return 60;
}


-(void)LayOutHeadView:(UIView *)view
{
    [leftImage setImage:[UIImage imageNamed:@"main_tag_title_tip"]];
}





@end
