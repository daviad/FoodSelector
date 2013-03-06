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
#define DATABASE_NAME  @"db_campus_cloud.db"
    	
#define TABLE_NAME_PERSONAL_MESSAGES       @"_goods"



#define CREATE_TABLE_PM @"CREATE TABLE " TABLE_NAME_PERSONAL_MESSAGES                                       \
                                "("                                                                         \
                                    PM_ID                       " TEXT PRIMARY KEY,"                        \
                                    PM_TYPE                     " TEXT,"                                    \
                                    PM_CONTENT_TYPE             " TEXT,"                                    \
                                    PM_TEXT                     " TEXT,"                                    \
                                    PM_DELETE                   " TEXT,"                                    \
                                    PM_DIRECTION                " TEXT,"                                    \
                                    PM_OTHER_ID                 " TEXT,"                                    \
                                    PM_IS_READ                  " TEXT,"                                    \
                                    PM_ATTACHEMENT                 " TEXT,"                                    \
                                    PM_TIME                     " TEXT,"                                     \
                                    PM_USERID                   " TEXT,"                                    \
                                    PM_MOBILE                   " TEXT,"                                    \
                                    PM_STATUS                   " TEXT,"                                     \
                                    PM_SPECIAL_EMO              " TEXT,"                                        \
                                    EXTENDS_1                       " TEXT,"                                    \
                                    EXTENDS_2                       " TEXT,"                                    \
                                    EXTENDS_3                       " TEXT"                                     \
                                ");"
#define CREATE_TABLE_PM_INDEX @"CREATE index pm_otherId_index on "TABLE_NAME_PERSONAL_MESSAGES"("PM_OTHER_ID");"


#endif //fmdbtest_DatabaseConstants_h


