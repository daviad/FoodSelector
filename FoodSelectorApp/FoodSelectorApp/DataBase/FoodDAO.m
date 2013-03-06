//
//  FoodDAO.m
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-6.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "FoodDAO.h"

@implementation FoodDAO
-(id)init
{
    if (self = [super init])
    {
        self.tableName = TABLE_NAME_FOOD;
    }
    return  self;
}

@end
