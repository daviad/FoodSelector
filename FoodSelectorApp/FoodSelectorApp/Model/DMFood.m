//
//  DMFood.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-3.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "DMFood.h"

@implementation DMFood
@synthesize foodId;
@synthesize name;
@synthesize price;
@synthesize selectedCount;
@synthesize type;
+(NSMutableArray *)converFromDBDicArr:(NSArray*)arr
{
    NSMutableArray *resultArr = [[NSMutableArray alloc] init];
    return resultArr;
}
-(void)converFromSingleDBDic:(NSDictionary *)dic
{
    self.name = [dic objectForKey:@""];
}
@end
