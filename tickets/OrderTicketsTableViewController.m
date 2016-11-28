//
//  OrderTicketsTableViewController.m
//  tickets
//
//  Created by 李祖翔 on 16/11/22.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "OrderTicketsTableViewController.h"

@interface OrderTicketsTableViewController ()
{
    NSString *fileName;
    NSString *doc;
    NSMutableArray *listofUsers;
    FMDatabase *db;
}
@end

@implementation OrderTicketsTableViewController
- (IBAction)cancelButtonPress:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[Database loadDataBase:doc filename:fileName];
    [Database createOrderedFile:doc filename:fileName];
    listofUsers=[self addObjectWithUserInfo];
    
    NSLog(@"%@",_TicketID);
    NSLog(@"%@",_Seat);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listofUsers count]+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==[tableView numberOfRowsInSection:[tableView numberOfSections] - 1] - 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddUser"];
        return cell;
    }else{
        UserInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];
        cell.nameLabel.text=[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"UserName"];
        cell.idLabel.text=[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"UserID"];
        return cell;
    }
}
-(NSMutableArray *)addObjectWithUserInfo{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from User"];
    NSMutableArray *searchResult;
    searchResult=[[NSMutableArray alloc] init];
    
    while ([resultSet  next])
    {
        [searchResult addObject:[resultSet resultDictionary]];
    }
    [db close];
    return searchResult;
}
-(void)refresh{
    if([listofUsers count]!=0){
        [listofUsers removeAllObjects];
        listofUsers=[self addObjectWithUserInfo];
    }else{
        listofUsers=[self addObjectWithUserInfo];
    }
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:YES];
    [self refresh];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        db = [FMDatabase databaseWithPath:fileName];
        [db open];
        [db executeUpdate:@"delete from User where id = ?;",[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"id"]];
        [listofUsers removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Order Tickets" preferredStyle:UIAlertControllerStyleAlert];
    
    //First Class
    UIAlertAction *First=[UIAlertAction actionWithTitle:@"First Class" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSLog(@"Top Clicked");
        NSLog(@"%@",[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"id"]);
        
        [Database orderTickets:[NSNumber numberWithInteger:[[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]] TicketID:_TicketID Seat:_Seat Level:[NSNumber numberWithInt:0] Price:_Price DataBase:db];
        
        UIAlertController *sucesss=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Order Sucesss" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [sucesss addAction:Cancel];
        [self presentViewController:sucesss animated:YES completion:nil];
        }];
    //Economic Class
    UIAlertAction *Second=[UIAlertAction actionWithTitle:@"Economic Class" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        NSLog(@"Second Clicked");
        [Database orderTickets:[NSNumber numberWithInteger:[[[listofUsers objectAtIndex:indexPath.row] valueForKey:@"id"] integerValue]] TicketID:_TicketID Seat:_Seat Level:[NSNumber numberWithInt:1] Price:_DisPrice DataBase:db];
        UIAlertController *sucesss=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Order Sucesss" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [sucesss addAction:Cancel];
    }];
    UIAlertAction *Cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        nil;
        
    }];
    [alert addAction:First];
    [alert addAction:Second];
    [alert addAction:Cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
