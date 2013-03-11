//
//  BaseDAO.m
//  DataBase
//
//  Created by hh k on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BaseDAO.h"
#import "DatabaseTablesSingleton.h"



static NSDictionary *tableMap = nil;
static NSDictionary *columnMap = nil;
static NSDictionary *dicColumnMap = nil;


@implementation OrderPair

@synthesize key = _key;
@synthesize order = _order;
-(id)initWitKey:(NSString *)key withOrder:(NSString *)order
{
  
    if(self = [super init])
    {
        self.key = key;
        if([[order uppercaseString] isEqualToString:ASC] || [[order uppercaseString] isEqualToString:DESC])
            self.order = order;
        else
            self.order = @"";
    }
    return self;
}
-(id)initWitKey:(NSString *)key withOrderFlag:(BOOL)order
{
    self = [super init];
    if(self)
    {
        self.key = key;
        self.order = order ? ASC :DESC;
    }
    return self;
}


@end


@implementation BaseDAO
@synthesize tableName = _tableName;



@synthesize databaseManager = _databaseManager;

-(id) init
{
    self = [super init];
    if(self)
    {
        _databaseManager  = [DataBaseManager sharedInstance];
        if(!tableMap)
        {
            tableMap = [[DatabaseTablesSingleton sharedInstance] TablesMap];
            columnMap = [[DatabaseTablesSingleton sharedInstance] TablesInsertSQLMap];
            dicColumnMap = [[DatabaseTablesSingleton sharedInstance] TablesInsertDicMap];
        }
    }
    return self;
}



-(id)search:(NSDictionary *)dic type:(int)type waitUntiDone:(BOOL)flag
{
    NSString *sql = [self generateQuerySQLWith:dic];
    return [self.databaseManager query:sql param:dic type:type waitUntilDone:flag];
}

-(id)search:(NSDictionary *)dic withOrderKey:(NSString*)key withOrder:(NSString*)order type:(int)type waitUntiDone:(BOOL)flag
{
    NSString *sql = [self generateQuerySQLWith:dic];
    sql = [sql stringByAppendingFormat:@" order by %@ %@",key,order];
    return [self.databaseManager query:sql param:dic type:type waitUntilDone:flag];
}

-(id)search:(NSDictionary *)dic withOrderPari:(id)orders type:(int)type waitUntiDone:(BOOL)flag
{
    NSString *sql = [self generateQuerySQLWith:dic];
    NSString *orderFormat = @" %@ %@ ";
    NSMutableArray *orderArray = [[NSMutableArray alloc] init];
    if([orders isKindOfClass:[NSArray class]])
    {
        for(OrderPair *order in orders)
            [orderArray addObject:[NSString stringWithFormat:orderFormat,order.key,order.order]];
    }
    else
        [orderArray addObject:[NSString stringWithFormat:orderFormat,((OrderPair *)orders).key,((OrderPair *)orders).order]];
    NSString *ordersql = nil;
    if([orderArray count])
        ordersql = [orderArray componentsJoinedByString:@" , "];
    if(ordersql)
        sql = [sql stringByAppendingFormat:@" order by %@",ordersql];
    return [self.databaseManager query:sql param:dic type:type waitUntilDone:flag];
}

- (id)searchWithSQL:(NSString *)sql type:(int)type waitUntiDone:(BOOL)flag
{
    return [self.databaseManager query:sql param:nil type:type waitUntilDone:flag];
}

- (id)searchWithSQL:(NSString *)sql param:(NSDictionary *)dic type:(int)type waitUntiDone:(BOOL)flag
{
    return [self.databaseManager query:sql param:dic type:type waitUntilDone:flag];
}


-(void)update:(NSString *)sql parameter:(id)param type:(int)type waitUntilDone:(BOOL)flag
{
    void (^saveBlock) (FMDatabase *db, BOOL *rollback) = ^(FMDatabase *db, BOOL *rollback){
        if([param isKindOfClass:[NSDictionary class]] || [param isKindOfClass:[NSMutableDictionary class]])
            [db executeUpdate:sql withParameterDictionary:param];
        else if([param isKindOfClass:[NSArray class]] || [param isKindOfClass:[NSMutableArray class]])
        {
            for(id dic in param)
                [db executeUpdate:sql withParameterDictionary:dic];
        }
        else if (!param)
        {
            [db executeUpdate:sql];
        }
        else
            [db executeQuery:sql,param];
        if([db hadError])
            RCError(@"Error %d : %@",[db lastErrorCode],[db lastErrorMessage]);
    };
    [self.databaseManager update:saveBlock type:type waitUntilDone:flag];
}


-(id)removeUnusedKey:(id)arg fromTable:(NSString *)table
{
    if(!arg) return nil;
    if([arg isKindOfClass:[NSArray class]] || [arg isKindOfClass:[NSMutableArray class]])
    {
        NSMutableArray *argArray = [[NSMutableArray alloc] init] ;
        for(NSDictionary *dic in arg)
        {
            [argArray addObject:[self removeUnusedKeyFromDic:dic fromTable:table]];
        }
        return argArray;
    }
    else 
        return [self removeUnusedKeyFromDic:arg fromTable:table];
}


-(NSDictionary *)removeUnusedKeyFromDic:(NSDictionary *)dic fromTable:(NSString *)table
{
    NSArray *columns = [tableMap valueForKey:table];
    NSMutableDictionary *muteableDic  = [[NSMutableDictionary alloc] init];
    for(NSString *string in columns)
    {
        NSString *key;
        if(![dic valueForKey:string])
            key = [string substringFromIndex:[string rangeOfString:table].length+1];  //remove "#TABLENAME_"
        else 
            key = string;
        [muteableDic setValue:[dic valueForKey:key] ? [dic valueForKey:key]:[NSNull null] forKey:string];
    }
    return muteableDic;
}



-(NSDictionary *)removeUnusedKeyForUpdateFromDic:(NSDictionary *)dic fromTable:(NSString *)table
{
    NSArray *columns = [tableMap valueForKey:table];
    NSMutableDictionary *muteableDic  = [[NSMutableDictionary alloc] init];
    for(NSString *string in columns)
    {
        NSString *key;
        if(![dic valueForKey:string])
            key = [string substringFromIndex:[string rangeOfString:table].length+1];  //remove "#TABLENAME_"
        else
            key = string;
        if([dic valueForKey:key])
            [muteableDic setValue:[dic valueForKey:key] forKey:string];
    }
    return muteableDic;
}

-(void)save:(id)data type:(int)type waitUntilDone:(BOOL)flag
{
    if(!data || ([data isKindOfClass:[NSArray class]] && [data count] == 0))
    {
        [self.databaseManager callBack:nil type:type];
        return;
    }
    NSString *sql  = [self generateAddOrUpdateSQL:self.tableName];
    id parameter = [self removeUnusedKey:data fromTable:self.tableName];
    if(parameter)
        [self update:sql parameter:parameter type:type waitUntilDone:flag];
}



-(void)update:(NSDictionary *)dic ByPrimeKeyValue:(id)key type:(int)type waitUntilDone:(BOOL)flag
{
    if(!dic || [[dic allKeys] count] == 0) return;
    NSDictionary *tmpDic = [self removeUnusedKeyForUpdateFromDic:dic fromTable:self.tableName];
    NSString *sql = [self generateUpdateSQL:tmpDic withPrimeKey:key];
    [self update:sql parameter:tmpDic type:type waitUntilDone:flag];
}


-(void)excute:(NSString *)sql type:(int)type waitUntilDone:(BOOL)flag
{
    [self update:sql parameter:nil type:type waitUntilDone:flag];
}


-(void)deleteByPrimeKey:(id)key type:(int)type waitUntilDone:(BOOL)flag
{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:key forKey:[[tableMap valueForKey:self.tableName] objectAtIndex:0]];
    [self deleteByParam:dic type:type waitUntilDone:flag];
}


-(void)deleteByParam:(id)data type:(int)type waitUntilDone:(BOOL)flag
{
    NSString *sql;
    if([data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSMutableArray class]])
        sql = [self generateDeleteSQLWithDic:[data lastObject]];
    else
        sql = [self generateDeleteSQLWithDic:data];
    [self update:sql parameter:data type:type waitUntilDone:flag];
}



#pragma mark methods to help generate the sql string
#define SQL_REPLACE @"REPLACE INTO %@(%@) VALUES(%@)"
-(NSString *)generateAddOrUpdateSQL:(NSString *)tableName
{
    NSString *columns = [columnMap valueForKey:tableName];
    NSString *dicnames = [dicColumnMap valueForKey:tableName];
    return [NSString stringWithFormat:SQL_REPLACE,tableName,columns,dicnames];
}


#define SQL_UPDATE_PRIME_KEY_STRING @"UPDATE %@ SET %@ WHERE %@ = '%@'"
#define SQL_UPDATE_PRIME_KEY_INT @"UPDATE %@ SET %@ WHERE %@ = %@"
-(NSString *)generateUpdateSQL:(NSDictionary *)dic withPrimeKey:(id)value
{
    NSString *columns = [self generateUpdateSQLWithDic:dic];
    NSString *sqlUpdate = [value isKindOfClass:[NSString class]] ? SQL_UPDATE_PRIME_KEY_STRING : SQL_UPDATE_PRIME_KEY_INT;
    return [NSString stringWithFormat:sqlUpdate,self.tableName,columns, [[tableMap valueForKey:self.tableName] objectAtIndex:0], value];
}

#define SQL_UPDATE_DIC @"%@ = :%@ "
#define UPDATE_JOINED_STRING @" , "
-(NSString *)generateUpdateSQLWithDic:(NSDictionary *)dic
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[[dic allKeys] count]];
    for(NSString *string in [dic allKeys])
        [array addObject:[NSString stringWithFormat:SQL_UPDATE_DIC,string,string]];
    return [array componentsJoinedByString:UPDATE_JOINED_STRING];
}


#define SELECT_QUERY    @"SELECT * FROM %@ WHERE ( %@ ) "
#define CONDITION_WITH_KEY  @" %@ = (:%@) AND"
#define LengthOfAnd         3
-(NSString *)generateQuerySQLWith:(NSDictionary *)dic
{
    NSString *condition = @"";
    if ([dic allValues].count>0)
    {
        for (NSString *column in [dic allKeys])
            condition = [condition stringByAppendingFormat:CONDITION_WITH_KEY,column,column];
        int len = [condition length]- LengthOfAnd;
        if (len<0) {
            len = 0;
        }
        condition = [condition substringToIndex:len];

    }
    else
    {
        condition = @"1=1";
    }
     
    NSString *sql = [NSString stringWithFormat:SELECT_QUERY,self.tableName,condition];
    return sql;
}


#define DELETE_SQL    @"DELETE FROM %@ WHERE %@"
-(NSString *)generateDeleteSQLWithDic:(NSDictionary *)dic
{
    NSString *condition = @"";
    for (NSString *column in [dic allKeys])
        condition = [condition stringByAppendingFormat:CONDITION_WITH_KEY,column,column];
    condition = [condition substringToIndex:[condition length]- LengthOfAnd];
    NSString *sql = [NSString stringWithFormat:DELETE_SQL,self.tableName,condition];
    return sql;
}


#define DELETE_SQL_WITH_PRIME_KEY    @"DELETE FROM %@ WHERE %@ = ?"
-(NSString *)generateDeleteSQLWithPrimeKey
{
    NSString *sql = [NSString stringWithFormat:DELETE_SQL_WITH_PRIME_KEY,self.tableName,[[tableMap valueForKey:self.tableName] objectAtIndex:0]];
    return sql;
}


+(NSString *)getColumByTableName:(NSString *)name byId:(int)index
{
    return [[tableMap valueForKey:name] objectAtIndex:index];
}


@end

