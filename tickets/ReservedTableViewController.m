//
//  ReservedTableViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/27.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "ReservedTableViewController.h"

@interface ReservedTableViewController ()
{
    NSString *fileName;
    NSString *doc;
    NSMutableArray *listofReserved;
    FMDatabase *db;
}
@end

@implementation ReservedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[Database loadDataBase:doc filename:fileName];
    listofReserved=[self addObjectWithReservedInfo];
}
-(void)viewWillAppear:(BOOL)animated{
  //  [self viewWillAppear:YES];
    [self refresh];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)addObjectWithReservedInfo{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from Ordered"];
    NSMutableArray *searchResult;
    searchResult=[[NSMutableArray alloc] init];
    
    while ([resultSet  next])
    {
        [searchResult addObject:[resultSet resultDictionary]];
    }
    [db close];
    return searchResult;
}
-(NSDictionary *)LookUpWithUser:(NSNumber *)UserID{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from User where id = (?)",[NSNumber numberWithInt:[UserID intValue]]];
    NSDictionary *searchResult;
    while([resultSet next]){
        searchResult=[resultSet resultDictionary];
    }
    [db close];
    return searchResult;
}
-(NSDictionary *)LookUpWithTicket:(NSNumber *)TicketID{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from Tickets where id = (?)",[NSNumber numberWithInt:[TicketID intValue]]];
    NSDictionary *searchResult;
    while([resultSet next]){
        searchResult=[resultSet resultDictionary];
    }
    [db close];
    return searchResult;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listofReserved count];
}
- (ReservedTicketCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReservedTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Reserved" forIndexPath:indexPath];
    NSDictionary *User;
    NSDictionary *Ticket;
    NSNumber *UserID;
    NSNumber *TicketID;
    NSNumber *Price;
    NSString *Level;
    UserID=[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"UserID"];
    TicketID=[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"TicketID"];
    Price=[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"Price"];

    if([[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"Level"] intValue]==0){
        Level=[NSString stringWithFormat:@"First"];
    }else{
        Level=[NSString stringWithFormat:@"Economic"];
    }
    User=[self LookUpWithUser:UserID];
    Ticket=[self LookUpWithTicket:TicketID];
    cell.DCity.text=[Ticket valueForKey:@"DCity"];
    cell.ACity.text=[Ticket valueForKey:@"ACity"];
    cell.DateAndTime.text=[NSString stringWithFormat:@"%@-%@",[Ticket valueForKey:@"DTime"],[Ticket valueForKey:@"ATime"]];
    cell.FlightAndAirplane.text=[NSString stringWithFormat:@"%@  %@",[Ticket valueForKey:@"FlightNo"],[Ticket valueForKey:@"AirplaneNo"]];
    cell.Name.text=[User valueForKey:@"UserName"];
    cell.ID.text=[User valueForKey:@"UserID"];
    cell.Price.text=[NSString stringWithFormat:@"%@",Price];
    cell.Level.text=Level;
    cell.RefundButton.tag=indexPath.row;
    [cell.RefundButton addTarget:self action:@selector(refundButttonPress:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
-(void)refresh{
    if([listofReserved count]!=0){
        [listofReserved removeAllObjects];
        listofReserved=[self addObjectWithReservedInfo];
    }else{
        listofReserved=[self addObjectWithReservedInfo];
    }
    [self.tableView reloadData];
}
-(void)deleteReserved{
    NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    NSLog(@"%@",[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"id"]);
    [db executeUpdate:@"delete from Ordered where id = ?;",[[listofReserved objectAtIndex:indexPath.row] valueForKey:@"id"]];
    [listofReserved removeObjectAtIndex:indexPath.row];
    [db close];

}
- (void)refundButttonPress:(UIButton *)sender {
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    NSLog(@"%@",[[listofReserved objectAtIndex:sender.tag] valueForKey:@"id"]);
    [db executeUpdate:@"delete from Ordered where id = ?;",[[listofReserved objectAtIndex:sender.tag] valueForKey:@"id"]];
    [listofReserved removeObjectAtIndex:sender.tag];
    [self refresh];
    [db close];
}
-(void)freeUpgrade{
    
}
@end
