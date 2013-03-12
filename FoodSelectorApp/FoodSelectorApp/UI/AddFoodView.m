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
@synthesize tagArr;
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
    int const W = 80;
    int const H = 29;
    int x = 8;
    int y = 5;
    for (int i = 0; i<tagArr.count; i++)
    {
        x = (i % 3) * (W +8) + 12;
        y = (i / 3) * (H+8) + 7;
        UIButton *tagBtn = [[UIButton alloc] initWithFrame:CGRectMake(x, y, W, H)];
        [view addSubview:tagBtn];
        [tagBtn setTitle:[tagArr objectAtIndex:i] forState:UIControlStateNormal];
        tagBtn.tag = 200+i;
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        tagBtn.backgroundColor = kColorWithValue(0xa0d5c5);
        
        [tagBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    return y+H +15;
}


-(void)LayOutHeadView:(UIView *)view
{
    [leftImage setImage:[UIImage imageNamed:@"main_tag_title_tip"]];
}





@end
