//
//  DMFood.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-3.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "DMFood.h"
#import "FoodDAO.h"
@interface DMFood()
{
    FoodDAO *dao;
}
@end

@implementation DMFood
@synthesize foodId;
@synthesize name;
@synthesize price;
@synthesize selectedCount;
@synthesize type;

-(id)init
{
    if (self = [super init])
    {
        dao = [[FoodDAO alloc] init];
        dao.tableName = TABLE_NAME_FOOD;
    }
    return self;
}
+(NSMutableArray *)converFromDBDicArr:(NSArray*)arr
{
    NSMutableArray *resultArr = [[NSMutableArray alloc] initWithCapacity:arr.count];
    for (NSDictionary *dic in arr)
    {
        DMFood *food = [[DMFood alloc] init];
        [food converFromSingleDBDic:dic];
        [resultArr addObject:food];
    }
    return resultArr;
}
-(void)converFromSingleDBDic:(NSDictionary *)dic
{
    self.name = [dic objectForKey:FOOD_NAME];
    self.foodId = [dic objectForKey:FOOD_ID];
}


-(NSMutableArray *)searchAllFood
{
    NSArray* arr = [dao search:[NSDictionary dictionary] type:0 waitUntiDone:YES];
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:arr.count];
    
    resultArr = [DMFood converFromDBDicArr:arr];
 
    return  resultArr;
}
@end
