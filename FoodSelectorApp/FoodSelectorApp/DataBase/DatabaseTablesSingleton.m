//
//  DatabaseTablesSingleton.m
//  LoochaUtilities
//
//  Created by hh k on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatabaseTablesSingleton.h"
static DatabaseTablesSingleton *sharedInstance;


@implementation DatabaseTablesSingleton
@synthesize TablesMap = _TablesMap;
@synthesize TablesInsertSQLMap = _TablesInsertSQLMap;
@synthesize TablesInsertDicMap = _TablesInsertDicMap;



+ (DatabaseTablesSingleton *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DatabaseTablesSingleton alloc] init];
    });
    return sharedInstance;
}


+ (void)releaseInstance
{
   // [sharedInstance release];
}



-(id)init
{
    if(self = [super init])
    {
        _TablesMap = [[NSMutableDictionary alloc] init];
        _TablesInsertSQLMap = [[NSMutableDictionary alloc] init];
        _TablesInsertDicMap = [[NSMutableDictionary alloc] init];
        
        

        NSArray *foodArr = [NSArray arrayWithObjects:
                            FOOD_ID,
                            FOOD_NAME,
                            FOOD_PRICE,
                            FOOD_TYPE,
                            FOOD_URL, nil];
        [self setMap:TABLE_NAME_FOOD Value:foodArr];
        
    }
    return self;
}

-(void)setMap:(NSString*) tableName Value:(NSArray *)value
{
    
    NSString *columns = @"";
    NSString *dicColumns = @"";
    for(NSString *string in value)
    {
        columns = [columns stringByAppendingFormat:@"%@,",string];
        dicColumns = [dicColumns stringByAppendingFormat:@":%@,",string];
    }
    columns = [columns substringToIndex:[columns length] -1];
    dicColumns = [dicColumns substringToIndex:[dicColumns length]-1];
    
    [_TablesMap setValue:value forKey:tableName];
    [_TablesInsertSQLMap setValue:columns forKey:tableName];
    [_TablesInsertDicMap setValue:dicColumns forKey:tableName];
}


//-(void)dealloc
//{
//    [_TablesMap release];
//    [_TablesInsertSQLMap release];
//    [_TablesInsertDicMap release];
//    [super dealloc];
//}



@end 
