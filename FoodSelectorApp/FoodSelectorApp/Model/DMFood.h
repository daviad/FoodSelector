//
//  DMFood.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-3.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMFood : NSObject
@property(nonatomic,strong)NSString* foodId;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,assign)NSInteger selectedCount;
@property(nonatomic,assign)NSInteger type;


+(NSMutableArray *)converFromDBDicArr:(NSArray*)arr;
-(void)converFromSingleDBDic:(NSDictionary *)dic;
-(NSMutableArray *)searchAllFood;
@end
