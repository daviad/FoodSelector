//
//  FoodListCell.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "FoodListCell.h"
#import "FoodLB.h"


@interface FoodListCell ()
{
    FoodLB *lb1;
    FoodLB *lb2;
    FoodLB *lb3;
    FoodLB *lb4;
}

@end

@implementation FoodListCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        lb1 = [[FoodLB alloc] initWithFrame:CGRectMake(0, 0, 320/FoodColumCount, 44)];
        lb1.LBDelegate= self;
        
        
        lb2 = [[FoodLB alloc] initWithFrame:CGRectMake(320/4, 0, 320/FoodColumCount, 44)];
        lb2.LBDelegate= self;

        lb3 = [[FoodLB alloc] initWithFrame:CGRectMake(320/2, 0, 320/FoodColumCount, 44)];
        lb3.LBDelegate= self;

        lb4 = [[FoodLB alloc] initWithFrame:CGRectMake(320/4*3, 0, 320/FoodColumCount, 44)];
        lb4.LBDelegate= self;

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

-(void)loadData:(NSArray*)arr
{
//    for (int i; i<arr.count; i++)
//    {
    [lb1 removeFromSuperview];
    [lb2 removeFromSuperview];
    [lb3 removeFromSuperview];
    [lb4 removeFromSuperview];
    
    lb1.alpha = 1;
    lb2.alpha = 1;
    lb3.alpha = 1;
    lb4.alpha = 1;
    
    
    if (0 == arr.count)
    {


    }
    
    if (1==arr.count) {
        DMFood *food1 = [arr objectAtIndex:0];
        [lb1 updateData:food1];
     
        [self.contentView addSubview:lb1];
        

    }

    if (2 == arr.count)
    {
        DMFood *food1 = [arr objectAtIndex:0];
        [lb1 updateData:food1];

        
        DMFood *food2 = [arr objectAtIndex:1];
        [lb2 updateData:food2];
        
        [self.contentView addSubview:lb1];
        [self.contentView addSubview:lb2];
        

    }

    if (3 == arr.count)
    {
        DMFood *food1 = [arr objectAtIndex:0];
        [lb1 updateData:food1];
        
        
        DMFood *food2 = [arr objectAtIndex:1];
        [lb2 updateData:food2];
        
        DMFood *food3 = [arr objectAtIndex:2];
        [lb3 updateData:food3];
        
        [self.contentView addSubview:lb1];
        [self.contentView addSubview:lb2];
        [self.contentView addSubview:lb3];

    }
    
    if (4 ==arr.count)
    {
        DMFood *food1 = [arr objectAtIndex:0];
        [lb1 updateData:food1];
        
        
        DMFood *food2 = [arr objectAtIndex:1];
        [lb2 updateData:food2];
        
        DMFood *food3 = [arr objectAtIndex:2];
        [lb3 updateData:food3];
        
        DMFood *food4 = [arr objectAtIndex:3];
        [lb4 updateData:food4];
        
        
        [self.contentView addSubview:lb1];
        [self.contentView addSubview:lb2];
        [self.contentView addSubview:lb3];
        [self.contentView addSubview:lb4];
    }

    
//    }
}



//删除动画
-(void)deleteAnimateion:(id)deletV
{
    NSMutableArray *vArr = [NSMutableArray array];

    for (UIView *v in  self.contentView.subviews)
    {
        if ([v isKindOfClass:[FoodLB class]])
        {
            [vArr addObject:v];
        }
    }
    
  [vArr removeObject:deletV];
    
    
}


-(void)deleteFood:(FoodLB*)lb
{
    
    [UIView animateWithDuration:0.3 animations:^{
        lb.alpha = 0;
    } completion:^(BOOL finished) {
         [delegate deleteFood:lb.food];
    }];
    
   
}
@end
