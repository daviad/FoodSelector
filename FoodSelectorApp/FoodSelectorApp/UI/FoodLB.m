//
//  FoodLB.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "FoodLB.h"

@interface FoodLB()
{
    UILabel *content;
  
}

@end

@implementation FoodLB
@synthesize LBDelegate;
@synthesize food;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        content = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 7, 7)];
        content.textAlignment = NSTextAlignmentCenter;
        content.textColor = [UIColor whiteColor];
        content.backgroundColor = [UIColor colorWithRed:210.0/255 green:133.0/255 blue:122.0/255 alpha:1];
        [self addSubview:content];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-16, 1, 15, 15)];
        deleBtn.backgroundColor = [UIColor redColor];
        [deleBtn addTarget:self action:@selector(deleteFood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
    }
    return self;
}
-(void)updateData:(DMFood *)f
{
    content.text = f.name;
    self.food = f;
}

-(void)deleteFood
{
    [LBDelegate deleteFood:self];
}

@end
