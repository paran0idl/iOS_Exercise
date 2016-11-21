//
//  ViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/4.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"
@interface ViewController ()
@property (nonatomic, retain) NSString * dbPath;
@property (nonatomic, retain) NSString * doc;
@property (nonatomic, retain) NSString *fileName;
@end

@implementation ViewController
@synthesize dbPath,doc,fileName;

- (void)viewDidLoad {
    [super viewDidLoad];
   
}
- (IBAction)create:(UIButton *)sender {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    self.doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    self.fileName = [doc stringByAppendingPathComponent:@"Tickets.sqlite"];
    if ([fileManager fileExistsAtPath:self.fileName] == NO) {
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:self.fileName];
        if ([db open]) {
            NSString * sql = @"CREATE TABLE 'Tickets' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'FlightNo' VARCHAR(30), 'AirplaneNo' VARCHAR(30),'DCity' VARCHAR(30),'ACity' VARCHAR(30),'DTime' VARCHAR(30),'ATime' VARCHAR(30),'Price' VARCHAR(30),'DisPrice' VARCHAR(30),'TotalT' VARCHAR(30),'LeftT' VARCHAR(30))";
            BOOL res = [db executeUpdate:sql];

            if (!res) {
               NSLog(@"error when creating db table");
            } else {
                NSLog(@"succ to creating db table");
                NSLog(@"%@",self.fileName);
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }else{
        NSLog(@"File exist");
    }
}
- (IBAction)insert:(UIButton *)sender {
    FMDatabase * db = [FMDatabase databaseWithPath:self.fileName];
    if ([db open]) {
        NSString * sql = @"insert into Tickets (FlightNo,AirplaneNo,DCity,ACity,DTime,ATime,Price,DisPrice,TotalT,LeftT) values(?,?,?,?,?,?,?,?,?,?)";
        BOOL res = [db executeUpdate:sql,@"HU7348",@"333",@"Chengdu",@"Bruxelles",@"0800",@"0545",@"1691",@"1000",@"200",@"5"];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
}
- (IBAction)delete:(UIButton *)sender {
    FMDatabase * db = [FMDatabase databaseWithPath:self.fileName];
    if ([db open]) {
        [db executeUpdate:@"DELETE FROM Tickets WHERE FlightNo = ?",@""];
        [db close];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
