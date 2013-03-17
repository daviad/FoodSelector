//
//  FoodListController.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "BaseiAdViewController.h"
#import "MaskView.h"
#import "FoodListCell.h"

#define MessageTypeSaveFood   101

@interface FoodListController : BaseiAdViewController<UITableViewDelegate,UITableViewDataSource,MaskViewDelegate,FoodListCellDelegate>

-(id)initWithFoodArr:(NSMutableArray*)arr;
@end
