//
//  FoodListCell.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMFood.h"  
#define FoodColumCount   4
@interface FoodListCell : UITableViewCell
-(void)loadData:(NSArray*)arr;
@end
