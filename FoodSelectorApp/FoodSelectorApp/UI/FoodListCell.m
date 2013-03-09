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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
        lb1 = [[FoodLB alloc] initWithFrame:CGRectMake(0, 0, 320/FoodColumCount, 44)];
        [self.contentView addSubview:lb1];
        lb2 = [[FoodLB alloc] initWithFrame:CGRectMake(0, 320/4, 320/FoodColumCount, 44)];
        [self.contentView addSubview:lb2];
        lb3 = [[FoodLB alloc] initWithFrame:CGRectMake(0, 320/2, 320/FoodColumCount, 44)];
        [self.contentView addSubview:lb3];
        lb4 = [[FoodLB alloc] initWithFrame:CGRectMake(0, 320/2*3, 320/FoodColumCount, 44)];
        [self.contentView addSubview:lb4];
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
    DMFood *food1 = [arr objectAtIndex:0];
    [lb1 setText:food1.name];
    
    DMFood *food2 = [arr objectAtIndex:1];
    [lb2 setText:food2.name];
    
    DMFood *food3 = [arr objectAtIndex:2];
    [lb3 setText:food3.name];
    
    DMFood *food4 = [arr objectAtIndex:3];
    [lb4 setText:food4.name];
    
//    }
}

@end
