//
//  Database.h
//  tickets
//
//  Created by 李祖翔 on 2016/11/4.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface Database : NSObject
@property (nonatomic, retain) NSString * doc;
@property (nonatomic, retain) NSString *fileName;
+(void)insertToDataBase:(NSString *)FlightNo AirplaneNo:(NSString *)AirplaneNo DCity:(NSString *)DCity ACity:(NSString *)ACity DTime:(NSString *)DTime ATime:(NSString *)ATime Price:(NSString *)Price DisPrice:(NSString *)DisPrice TotalT:(NSString *)TotalT LeftT:(NSString *)LeftT DataBase:(FMDatabase *)db;
+(void)insertUserFileToDataBase:(NSString *)UserName UserID:(NSString *)UserID UserSex:(NSString *)UserSex DateOfBirth:(NSString *)DateOfBirth DataBase:(FMDatabase *)db;
+(void)createDataBase:(NSString *)doc filename:(NSString *)fileName;
+(void)createUserFile:(NSString *)doc filename:(NSString *)fileName;
+(void)createOrderedFile:(NSString *)doc filename:(NSString *)fileName;
+(NSString *)loadDataBase:(NSString *)doc filename:(NSString *)fileName;
+(void)orderTickets:(NSNumber *)UserID TicketID:(NSNumber *)TicketID Seat:(NSNumber *)Seat Level:(NSNumber *)Level Price:(NSNumber *)Price DataBase:(FMDatabase *)db;
@end
