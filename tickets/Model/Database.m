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

        FMDatabase * db = [FMDatabase databaseWithPath:fileName];
        if ([db open]) {
            NSString * sql = @"CREATE TABLE 'Tickets' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'FlightNo' VARCHAR(30), 'AirplaneNo' VARCHAR(30),'DCity' VARCHAR(30),'ACity' VARCHAR(30),'DTime' VARCHAR(30),'ATime' VARCHAR(30),'Price' INTEGER,'DisPrice' INTEGER,'TotalT' INTEGER,'LeftT' INTEGER,'isBooked' BOOLEAN,'FirstSeat'INTEGER,'Date'VARCHAR(30))";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table tickets");
                [db close];
            } else {
                NSLog(@"succ to creating db table tickets");
                NSLog(@"%@",fileName);
                [db close];
            }
        } else {
            NSLog(@"error when open db");
        }
}
+(void)createUserFile:(NSString *)doc filename:(NSString *)fileName{
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'User' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'UserName' VARCHAR(30), 'UserID' VARCHAR(30),'UserSex' VARCHAR(10),'DateOfBirth' VARCHAR(30))";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when creating db table user");
            [db close];
        } else {
            NSLog(@"succ to creating db table user");
            NSLog(@"%@",fileName);
            [db close];
        }
    } else {
        NSLog(@"error when open db");
    }
}
+(void)createOrderedFile:(NSString *)doc filename:(NSString *)fileName{
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'Login' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'Username'VARCHAR(30),'Password'VARCHAR(30))";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when creating db table login");
            [db close];
        } else {
            NSLog(@"succ to creating db table login");
            NSLog(@"%@",fileName);
            [db close];
        }
    } else {
        NSLog(@"error when open db");
    }
}
+(void)createLoginFile:(NSString *)doc filename:(NSString *)fileName{
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'Ordered' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'UserID' INTEGER, 'TicketID'INTEGER,'Seat'INTEGER,'Level'INTEGER,'Price'INTEGER)";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when creating db table user");
            [db close];
        } else {
            NSLog(@"succ to creating db table user");
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
        [self createUserFile:Doc filename:FileName];
        [self createOrderedFile:Doc filename:FileName];
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
+(void)insertUserFileToDataBase:(NSString *)UserName UserID:(NSString *)UserID UserSex:(NSString *)UserSex DateOfBirth:(NSString *)DateOfBirth DataBase:(FMDatabase *)db{
    
    if ([db open]) {
        NSString * sql = @"insert into User (UserName,UserID,UserSex,DateOfBirth) values(?,?,?,?)";
        BOOL res = [db executeUpdate:sql,UserName,UserID,UserSex,DateOfBirth];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
}
+(void)insertLoginFileToDataBase:(NSString *)Username Password:(NSString *)Password DataBase:(FMDatabase *)db{
    
    if ([db open]) {
        NSString * sql = @"insert into Login (Username,Password) values(?,?)";
        BOOL res = [db executeUpdate:sql,Username,Password];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
}
+(void)orderTickets:(NSNumber *)UserID TicketID:(NSNumber *)TicketID Seat:(NSNumber *)Seat Level:(NSNumber *)Level Price:(NSNumber *)Price DataBase:(FMDatabase *)db{
    if ([db open]) {
        NSString * sql = @"insert into Ordered (UserID,TicketID,Seat,Level,Price) values(?,?,?,?,?)";
        BOOL res = [db executeUpdate:sql,UserID,TicketID,Seat,Level,Price];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        sql=@"UPDATE Tickets SET LeftT = LeftT-1 WHERE id = (?)";
        res=[db executeUpdate:sql,TicketID];
        if (!res) {
            NSLog(@"error to change ticket");
        } else {
            NSLog(@"succ to change ticket");
        }
        if([Level intValue]==0){
            sql=@"UPDATE Tickets SET FirstSeat = FirstSeat-1 WHERE id = (?)";
            res=[db executeUpdate:sql,TicketID];
            if (!res) {
                NSLog(@"error to change seat");
            } else {
                NSLog(@"succ to change seat");
            }

        }
        [db close];
    }
    
}
+(void)refundTickets:(NSNumber *)TicketID Level:(NSNumber *)Level DataBase:(FMDatabase *)db{
    if ([db open]) {
        NSString * sql = @"UPDATE Tickets SET LeftT = LeftT+1 WHERE id = (?)";
        BOOL res = [db executeUpdate:sql,TicketID];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        if([Level intValue]==0){
            sql=@"UPDATE Tickets SET FirstSeat = FirstSeat+1 WHERE id = (?)";
            res=[db executeUpdate:sql,TicketID];
            if (!res) {
                NSLog(@"error to change seat");
            } else {
                NSLog(@"succ to change seat");
            }
        }
        [db close];
    }
    
}

@end
