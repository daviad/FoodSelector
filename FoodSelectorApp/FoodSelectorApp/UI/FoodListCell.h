//
//  FoodListCell.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFood.h" 
#import "FoodLB.h"
#define FoodColumCount   4
@class DMFood;
@protocol FoodListCellDelegate <NSObject>
-(void)deleteFood:(DMFood*)food;
@end
@interface FoodListCell : UITableViewCell<FoodLB>
{
    id<FoodListCellDelegate>delegate;
}
@property    id<FoodListCellDelegate>delegate;

-(void)loadData:(NSArray*)arr;
@end
