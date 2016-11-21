//
//  Database.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/4.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "Database.h"
@implementation Database
@synthesize doc,fileName;
+(void)createDataBase:(NSString *)doc filename:(NSString *)fileName{
    /*NSFileManager * fileManager = [NSFileManager defaultManager];
    doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    fileName = [doc stringByAppendingPathComponent:@"Tickets.sqlite"];*/
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:fileName];
        if ([db open]) {
            NSString * sql = @"CREATE TABLE 'Tickets' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'FlightNo' VARCHAR(30), 'AirplaneNo' VARCHAR(30),'DCity' VARCHAR(30),'ACity' VARCHAR(30),'DTime' VARCHAR(30),'ATime' VARCHAR(30),'Price' INTEGER,'DisPrice' INTEGER,'TotalT' INTEGER,'LeftT' INTEGER,'isBooked' BOOLEAN)";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table");
                [db close];
            } else {
                NSLog(@"succ to creating db table");
                NSLog(@"%@",fileName);
                [db close];
            }
        } else {
            NSLog(@"error when open db");
        }
}
+(NSString *)loadDataBase:(NSString *)Doc filename:(NSString *)FileName{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    Doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    FileName = [Doc stringByAppendingPathComponent:@"Tickets.sqlite"];
    if ([fileManager fileExistsAtPath:FileName] == NO){
        [self createDataBase:Doc filename:FileName];
    }else{
        NSLog(@"File exist");
        NSLog(@"%@",FileName);
    }

    return FileName;
}
+(void)insertToDataBase:(NSString *)FlightNo AirplaneNo:(NSString *)AirplaneNo DCity:(NSString *)DCity ACity:(NSString *)ACity DTime:(NSString *)DTime ATime:(NSString *)ATime Price:(NSString *)Price DisPrice:(NSString *)DisPrice TotalT:(NSString *)TotalT LeftT:(NSString *)LeftT DataBase:(FMDatabase *)db{
    
    if ([db open]) {
        NSString * sql = @"insert into Tickets (FlightNo,AirplaneNo,DCity,ACity,DTime,ATime,Price,DisPrice,TotalT,LeftT) values(?,?,?,?,?,?,?,?,?,?)";
        BOOL res = [db executeUpdate:sql,FlightNo,AirplaneNo,DCity,ACity,DTime,ATime,Price,DisPrice,TotalT,LeftT];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
}
@end
