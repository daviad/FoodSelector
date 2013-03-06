//
//  DatabaseConstants.h
//  fmdbtest
//
//  Created by hh k on 12-9-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#ifndef fmdbtest_DatabaseConstants_h
#define fmdbtest_DatabaseConstants_h


	
#define DATABASE_VERSION  0


#pragma mark TableName
#define DATABASE_NAME  @"db_foodSelecte.db"
    	

#define TABLE_NAME_FOOD                    @"_food"




#define FOOD_ID        @"foodId"
#define FOOD_NAME        @"name"
#define FOOD_PRICE        @"price"
#define FOOD_TYPE        @"type"
#define FOOD_URL        @"url"

#define CREATE_TABLE_FOOD @"CREATE TABLE " TABLE_NAME_FOOD                                       \
"("                                                                         \
FOOD_ID                       " TEXT PRIMARY KEY,"                        \
FOOD_NAME                     " TEXT,"                                    \
FOOD_PRICE                    " TEXT,"                                    \
FOOD_TYPE                     " TEXT,"                                    \
FOOD_URL                      " TEXT"                                    \
");"


#endif //fmdbtest_DatabaseConstants_h


