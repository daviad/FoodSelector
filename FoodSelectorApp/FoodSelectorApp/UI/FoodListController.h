//
//  FoodListController.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "BaseiAdViewController.h"

@interface FoodListController : BaseiAdViewController<UITableViewDelegate,UITableViewDataSource>

-(id)initWithFoodArr:(NSMutableArray*)arr;
@end
