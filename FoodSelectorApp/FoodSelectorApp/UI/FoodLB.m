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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        content = [[UILabel alloc] initWithFrame:CGRectInset(frame, 5, 5)];
        content.textAlignment = NSTextAlignmentCenter;
        content.textColor = [UIColor yellowColor];
        
        self.backgroundColor = [UIColor clearColor];
        
        UIButton *deleBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-20, 0, 20, 20)];
        deleBtn.backgroundColor = [UIColor blackColor];
        [deleBtn addTarget:self action:@selector(deleteFood) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleBtn];
    }
    return self;
}
-(void)setText:(NSString*)text
{
    content.text = text;
}
-(void)deleteFood
{
    [LBDelegate deleteFood];
}

@end
