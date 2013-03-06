//
//  DataBaseManager.h
//  DataBase
//
//  Created by hh k on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "DatabaseConstants.h"

@interface DataBaseManager : NSObject
{
    FMDatabaseQueue *queue;
    FMDatabase *mainThreadDB;
    dispatch_queue_t databaseQueue;
}


+ (id)sharedInstance;
+ (void)releaseInstance;
- (void)update:(void (^)(FMDatabase *db, BOOL *rollback))block type:(int)type waitUntilDone:(BOOL)flag;
- (id)query:(NSString *)sql param:(NSDictionary *)dic type:(int)type waitUntilDone:(BOOL)flag;
- (void)callBack:(id)result type:(int)type;
@end
