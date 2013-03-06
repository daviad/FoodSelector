//
//  DatabaseTablesSingleton.h
//  LoochaUtilities
//
//  Created by hh k on 12-9-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseConstants.h"

@interface DatabaseTablesSingleton : NSObject

@property (nonatomic , readonly)NSMutableDictionary *TablesMap;
@property (nonatomic , readonly)NSMutableDictionary *TablesInsertSQLMap;
@property (nonatomic , readonly)NSMutableDictionary *TablesInsertDicMap;

+ (DatabaseTablesSingleton *)sharedInstance;
+ (void)releaseInstance;
@end
