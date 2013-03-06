//
//  RCLog.m
//  LoochaLog
//
//  Created by jinquan zhang on 12-9-24.
//  Copyright (c) 2012年 realcloud. All rights reserved.
//
#import "RCLog.h"
#include <stdio.h>

void RCRedirectLogToFile(NSString *filePath)
{
    freopen([filePath UTF8String], "w+", stderr);
}
