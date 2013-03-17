//
//  DataBaseManager.m
//  DataBase
//
//  Created by hh k on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DataBaseManager.h"
#import "DatabaseTablesSingleton.h"
@implementation DataBaseManager


static DataBaseManager *sharedInstance;

#define DataBaseQueue       "databaseQueue"

- (id)init 
{
    self = [super init];
    if(self)
    {
        NSString *docsPath = [self persistentStoreDirectory];
        NSString *storePath = [docsPath stringByAppendingPathComponent:DATABASE_NAME];
        [self openAndCreate:storePath];
        databaseQueue = dispatch_queue_create(DataBaseQueue, 0);
    }
    return self;
    
}

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataBaseManager alloc] init];
    });
	return sharedInstance;
}

+ (void)releaseInstance
{
    
   // [sharedInstance release];
}


- (void)dealloc
{
    [mainThreadDB close];
//    [mainThreadDB release];
//    [queue release];
//    [super dealloc];
}



- (NSString *)persistentStoreDirectory
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : NSTemporaryDirectory();
	NSString *appName = @"FoodSelecte";
	NSString *result = [basePath stringByAppendingPathComponent:appName];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath:result])
	{
		[fileManager createDirectoryAtPath:result withIntermediateDirectories:YES attributes:nil error:nil];
	}
    return result;
}



- (BOOL)openAndCreate:(NSString *)storePath
{
    mainThreadDB = [[FMDatabase alloc] initWithPath:storePath];
    if([mainThreadDB open])
    {
        RCDebug(@"begin create table");
        [mainThreadDB beginTransaction];
        [mainThreadDB executeUpdate:CREATE_TABLE_FOOD];
        if([mainThreadDB hadError])
            RCError(@"Error %d : %@",[mainThreadDB lastErrorCode],[mainThreadDB lastErrorMessage]);
        [mainThreadDB commit];
    }
    else
    {
        RCDebug(@"open db failed");
        return NO;
    }
    queue = [[FMDatabaseQueue alloc] initWithPath: storePath];
    return YES;
}


//-(void)tryToDropTable
//{
//    id databaseVersion = [[NSUserDefaults standardUserDefaults] valueForKey:kDatabaseDefault];
//    if(!databaseVersion)
//       [[NSUserDefaults standardUserDefaults] setValue:kCampusDatabaseVersion forKey:kDatabaseDefault];
//    else if(![databaseVersion isEqualToString:kCampusDatabaseVersion])
//    {
//        id user = [[NSUserDefaults standardUserDefaults] valueForKey:@"usr"];
//        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//        [[NSUserDefaults standardUserDefaults] setValue:user forKey:@"user"];
//        [[NSUserDefaults standardUserDefaults] setValue:kCampusDatabaseVersion forKey:kDatabaseDefault];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        NSString *sqlFormat = @"DROP TABLE IF EXISTS %@";
//        for(NSString *tableName in [[DatabaseTablesSingleton sharedInstance].TablesMap allKeys])
//        {
//            if(![tableName isEqualToString:TABLE_NAME_ACCOUNT])
//                [mainThreadDB executeUpdate:[NSString stringWithFormat:sqlFormat,tableName]];
//        }
//    }
//}


-(void)update:(void (^)(FMDatabase *db, BOOL *rollback))block type:(int)type waitUntilDone:(BOOL)flag 
{
    if(flag)
    {
        assert(![[NSThread currentThread] isMainThread]);   //main thread can not save data
        [queue inTransaction:block];
    }
    else 
    {
        dispatch_async(databaseQueue, ^{
            assert(![[NSThread currentThread] isMainThread]);
            [queue inTransaction:block];
            [self callBack:nil type:type];
        });
    }

}





-(id)query:(NSString *)sql param:(NSDictionary *)dic type:(int)type waitUntilDone:(BOOL)flag 
{
    __block NSMutableArray *result = [[NSMutableArray alloc] init] ;
    void (^queryBlock) (FMDatabase *db) = ^(FMDatabase *db){
        FMResultSet *rs;
        if(dic)
            rs = [db executeQuery:sql withParameterDictionary:dic];
        else 
            rs = [db executeQuery:sql];
        if([db hadError])
            RCError(@"Error %d : %@",[db lastErrorCode],[db lastErrorMessage]);
        while ([rs next]) {
            [result addObject:[self removeNSNullFromDic:[rs resultDictionary]]];
        }
    };
    if(flag)
    {
        if([[NSThread currentThread] isMainThread])
        {
            FMResultSet *rs;
            if(dic)
                rs = [mainThreadDB executeQuery:sql withParameterDictionary:dic];
            else 
                rs = [mainThreadDB executeQuery:sql];
            while ([rs next]) {
                [result addObject:[self removeNSNullFromDic:[rs resultDictionary]]];
            }
            return result ;
        }
        [queue inDatabase:queryBlock];
        return result;
    }
    else 
    {
        dispatch_async(databaseQueue, ^{
            assert(![[NSThread currentThread] isMainThread]);
            [queue inDatabase:queryBlock];
    
            [self callBack:result type:type];
           // result ;
        });
    }
    return nil;
    
}




-(void)callBack:(id)result type:(int)type
{
    RCTrace(@"%@,%d",result,type);
  //  [[NSNotificationCenter defaultCenter] postNotification:<#(NSNotification *)#>]
}

-(id)removeNSNullFromDic:(id)dic
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dic];
    for(NSString *key in [dic allKeys])
    {
        if([[dic valueForKey:key] isKindOfClass:[NSNull class]])
        {
            [result removeObjectForKey:key];
        }
    }
    return result;
}

@end
