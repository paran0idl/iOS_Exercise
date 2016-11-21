//
//  FlightInfoTableViewController.m
//  
//
//  Created by 李祖翔 on 2016/11/10.
//
//

#import "FlightInfoTableViewController.h"
#import "FlightInfoCell.h"
#import "Database.h"
#import "DetailViewController.h"
#import "enterInfo.h"


@interface FlightInfoTableViewController ()
{
    NSString *fileName;
    NSString *doc;
    NSMutableArray *listofFlights;
    FMDatabase *db;
}
@end

@implementation FlightInfoTableViewController
//@synthesize listofFlights;
- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[[NSString alloc] init];
    doc=[[NSString alloc] init];
    db=[[FMDatabase alloc] init];
    listofFlights=[[NSMutableArray alloc] init];
    fileName=[Database loadDataBase:doc filename:fileName];
    listofFlights=[self addObjectWithFlightInfo];
}
-(NSMutableArray *)addObjectWithFlightInfo{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from Tickets"];
    NSMutableArray *searchResult;
    searchResult=[[NSMutableArray alloc] init];
    
    while ([resultSet  next])
    {
        [searchResult addObject:[resultSet resultDictionary]];
    }
    [db close];
    return searchResult;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)returnData:(returnDataBlock)DataBlock{
    self.returnDataBlock=DataBlock;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listofFlights count];
}


- (FlightInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //cell.textLabel.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"FlightNo"];
    cell.DCity.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"DCity"];
    cell.ACity.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"ACity"];
    cell.DTime.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"DTime"];
    cell.ATime.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"ATime"];
    cell.FlightNo.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"FlightNo"];
    cell.AirPlaneNo.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"AirplaneNo"];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 //   [self performSegueWithIdentifier:@"detail" sender:self];
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        db = [FMDatabase databaseWithPath:fileName];
        [db open];
        [db executeUpdate:@"delete from Tickets where id = ?;",[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"id"]];
        [listofFlights removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
-(void)refresh{
    if([listofFlights count]!=0){
        [listofFlights removeAllObjects];
        listofFlights=[self addObjectWithFlightInfo];
    }else{
        listofFlights=[self addObjectWithFlightInfo];
    }
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:YES];
    [self refresh];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"detail"]){
    DetailViewController *detail=[[DetailViewController alloc] init];
    detail=[segue destinationViewController];
    NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
    detail.flightInfo=[listofFlights objectAtIndex:indexPath.row];
    }else if([segue.identifier isEqualToString:@"enterInfo"]){
        enterInfo *info=[[enterInfo alloc] init];
        info=[segue destinationViewController];
    }
}


@end
