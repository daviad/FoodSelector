//
//  FoodLB.h
//  FoodSelectorApp
//
//  Created by dxw on 13-3-9.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoodLB <NSObject>

-(void)deleteFood;

@end
@interface FoodLB : UIView
{
   __weak id<FoodLB> LBDelegate;
}
@property(nonatomic,weak)id<FoodLB>LBDelegate;
-(void)setText:(NSString*)text;
@end
