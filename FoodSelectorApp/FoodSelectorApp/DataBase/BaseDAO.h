//
//  BaseDAO.h
//  DataBase
//
//  Created by hh k on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "DataBaseManager.h"


#define ASC @"ASC"
#define DESC @"DESC"

@interface OrderPair : NSObject
@property(copy,nonatomic) NSString *key;
@property(copy,nonatomic) NSString *order;
-(id)initWitKey:(NSString *)key withOrder:(NSString *)order;
-(id)initWitKey:(NSString *)key withOrderFlag:(BOOL)order;
@end

@interface BaseDAO : NSObject
{

}
@property (readonly)     DataBaseManager *databaseManager;
@property (copy)     NSString *tableName;

#pragma mark base methods for saving and updating
-(void)save:(id)data type:(int)type waitUntilDone:(BOOL)flag;
-(void)update:(NSDictionary *)dic ByPrimeKeyValue:(id)key type:(int)type waitUntilDone:(BOOL)flag;
-(void)update:(NSString *)sql parameter:(id)param type:(int)type waitUntilDone:(BOOL)flag;
-(void)excute:(NSString *)sql type:(int)type waitUntilDone:(BOOL)flag;


#pragma mark base methods for deleteing
-(void)deleteByPrimeKey:(id)key type:(int)type waitUntilDone:(BOOL)flag;
-(void)deleteByParam:(id)data type:(int)type waitUntilDone:(BOOL)flag;


#pragma mark base methods for searching
-(id)search:(NSDictionary *)dic type:(int)type waitUntiDone:(BOOL)flag;
-(id)searchWithSQL:(NSString *)sql type:(int)type waitUntiDone:(BOOL)flag;
-(id)searchWithSQL:(NSString *)sql param:(NSDictionary *)dic type:(int)type waitUntiDone:(BOOL)flag;
-(id)search:(NSDictionary *)dic withOrderKey:(NSString*)key withOrder:(NSString*)order type:(int)type waitUntiDone:(BOOL)flag;
-(id)search:(NSDictionary *)dic withOrderPari:(id)orders type:(int)type waitUntiDone:(BOOL)flag;

#pragma mark normal function
+(NSString *)getColumByTableName:(NSString *)name byId:(int)index;

#pragma mark methods to help generate the sql string
-(NSString *)generateUpdateSQL:(NSDictionary *)dic withPrimeKey:(id)value;
-(NSString *)generateAddOrUpdateSQL:(NSString *)tableName;
-(NSString *)generateQuerySQLWith:(NSDictionary *)dic;
-(NSString *)generateUpdateSQLWithDic:(NSDictionary *)dic;


#pragma mark addition methods
-(NSDictionary *)removeUnusedKey:(NSDictionary *)dic fromTable:(NSString *)table;
@end
