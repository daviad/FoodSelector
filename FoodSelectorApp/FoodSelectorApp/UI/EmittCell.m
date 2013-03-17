//
//  EmittCell.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-17.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "EmittCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation EmittCell
+ (Class)layerClass
{
    //configure the UIView to have emitter layer
    return [CAEmitterLayer class];
}
@end
