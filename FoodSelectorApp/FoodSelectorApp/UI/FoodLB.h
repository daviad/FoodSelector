//
//  FoodLB.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFood.h"
@protocol FoodLB <NSObject>

-(void)deleteFood:(DMFood*)food;

@end
@interface FoodLB : UIView
{
   __weak id<FoodLB> LBDelegate;
    DMFood *food;
}
@property(nonatomic,weak)id<FoodLB>LBDelegate;

@property(nonatomic,strong)DMFood *food;

-(void)updateData:(DMFood *)f;
@end
