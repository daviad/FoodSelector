//
//  RCLog.h
//  LoochaLog
//
//  Created by jinquan zhang on 12-9-21.
//  Copyright (c) 2012年 realcloud. All rights reserved.
//

#ifndef LoochaLog_RCLog_h
#define LoochaLog_RCLog_h

#define RCFUNC_EMPTY ((void)0)

/*
 * Simple log settings
 */
//#define RCLOG_ENABLED
//#define RCLOG_LEVEL RCLOG_LEVEL_INFO

#define RCLOG_ENABLED
#define RCLOG_LEVEL RCLOG_LEVEL_ALL

/*
 * RCLog
 */
#ifndef RCLOG_ENABLED
#define RCLog(fmt, ...) RCFUNC_EMPTY
#else
#define RCLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#endif

/*
 * Log levels
 */
#define RCLOG_LEVEL_NONE  0 // ignore all logs
#define RCLOG_LEVEL_FATAL 1 // fatal error happens
#define RCLOG_LEVEL_ERROR 2 // error happens
#define RCLOG_LEVEL_WARN  3 // problem exists probably
#define RCLOG_LEVEL_INFO  4 // normal info
#define RCLOG_LEVEL_DEBUG 5 // debug info
#define RCLOG_LEVEL_TRACE 6 // verbose debug info
#define RCLOG_LEVEL_ALL   7 // active all logs

#ifndef RCLOG_LEVEL
#define RCLOG_LEVEL RCLOG_LEVEL_DEBUG
#endif


#ifndef DEBUG
#define RCLOG_LEVEL RCLOG_LEVEL_NONE
#endif







#if RCLOG_LEVEL < RCLOG_LEVEL_FATAL
#define RCFatal(fmt, ...) RCFUNC_EMPTY
#else
#define RCFatal(fmt, ...) RCLog(@"<FATAL>: %s(%d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#if RCLOG_LEVEL < RCLOG_LEVEL_ERROR
#define RCError(fmt, ...) RCFUNC_EMPTY
#else
#define RCError(fmt, ...) RCLog(@"<ERROR>: %s(%d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#if RCLOG_LEVEL < RCLOG_LEVEL_WARN
#define RCWarn(fmt, ...) RCFUNC_EMPTY
#else
#define RCWarn(fmt, ...) RCLog(@"<WARN>: %s(%d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#if RCLOG_LEVEL < RCLOG_LEVEL_INFO
#define RCInfo(fmt, ...) RCFUNC_EMPTY
#else
#define RCInfo(fmt, ...) RCLog(@"<INFO>: " fmt, ##__VA_ARGS__)
#endif

#if RCLOG_LEVEL < RCLOG_LEVEL_DEBUG
#define RCDebug(fmt, ...) RCFUNC_EMPTY
#else
#define RCDebug(fmt, ...) RCLog(@"<DEBUG>: %s(%d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

#if RCLOG_LEVEL < RCLOG_LEVEL_TRACE
#define RCTrace(fmt, ...) RCFUNC_EMPTY
#else
#define RCTrace(fmt, ...) RCLog(@"<TRACE>: %s(%d): " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#endif

void RCRedirectLogToFile(NSString *filePath);

#endif