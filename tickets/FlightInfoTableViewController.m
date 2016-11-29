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


@interface FlightInfoTableViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSString *fileName;
    NSString *doc;
    NSMutableArray *listofFlights;
    FMDatabase *db;
    NSMutableArray *searchList;
}
@end

@implementation FlightInfoTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[Database loadDataBase:doc filename:fileName];
    listofFlights=[self addObjectWithFlightInfo];
    
    //搜索框初始化
    self.searchController.searchBar.selectedScopeButtonIndex=0;
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.searchController.active){
        return  [searchList count];
    }else{
        return [listofFlights count];
    }
}


- (FlightInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(self.searchController.active){
        //
        int ticket=[[[searchList objectAtIndex:indexPath.row]valueForKey:@"LeftT"] intValue];
        
        //
        cell.DCity.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"DCity"];
        cell.ACity.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"ACity"];
        cell.DTime.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"DTime"];
        cell.ATime.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"ATime"];
        cell.FlightNo.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"FlightNo"];
        cell.AirPlaneNo.text=[[searchList objectAtIndex:indexPath.row] valueForKey:@"AirplaneNo"];
        cell.TicketStatus.text=[NSString stringWithFormat:@"余票:%d",ticket];
        if(ticket<20){
            cell.TicketStatus.textColor=[UIColor redColor];
        }else if (ticket<50){
            cell.TicketStatus.textColor=[UIColor yellowColor];
        }else{
            cell.TicketStatus.textColor=[UIColor greenColor];
        }
        
    }else{
        int ticket=[[[listofFlights objectAtIndex:indexPath.row]valueForKey:@"LeftT"] intValue];
    cell.DCity.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"DCity"];
    cell.ACity.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"ACity"];
    cell.DTime.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"DTime"];
    cell.ATime.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"ATime"];
    cell.FlightNo.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"FlightNo"];
    cell.AirPlaneNo.text=[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"AirplaneNo"];
        cell.TicketStatus.text=[NSString stringWithFormat:@"余票:%d",ticket];
        if(ticket<20){
            cell.TicketStatus.textColor=[UIColor redColor];
        }else if (ticket<50){
            cell.TicketStatus.textColor=[UIColor yellowColor];
        }else{
            cell.TicketStatus.textColor=[UIColor greenColor];
        }
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        db = [FMDatabase databaseWithPath:fileName];
        [db open];
        [db executeUpdate:@"delete from Tickets where id = ?;",[[listofFlights objectAtIndex:indexPath.row] valueForKey:@"id"]];
        [listofFlights removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }   
}
#pragma mark - 搜索代理
- (UISearchController *)searchController {
    if (_searchController == nil) {
        
        // 传入 nil 默认在原视图展示
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        // 成为代理
        _searchController.searchResultsUpdater = self;
        // 搜索时是否出现遮罩
        _searchController.dimsBackgroundDuringPresentation = NO;
        // 搜索栏的
        _searchController.searchBar.placeholder = @"请输入搜索内容";
        self.tableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.searchBar.selectedScopeButtonIndex=0;
        //_searchController.searchBar.showsScopeBar=YES;
        _searchController.searchBar.scopeButtonTitles=@[@"起飞城市",@"降落城市",@"航班号",@"Price"];
    }
    
    return _searchController;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // 获取搜索框文本
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate;
    // 判断数组中是否包含 searchString
    if(self.searchController.searchBar.selectedScopeButtonIndex==0){
        preicate = [NSPredicate predicateWithFormat:@"DCity BEGINSWITH[c] %@",searchString];
    }else if (self.searchController.searchBar.selectedScopeButtonIndex==1){
        preicate = [NSPredicate predicateWithFormat:@"ACity BEGINSWITH[c] %@",searchString];
    }else if(self.searchController.searchBar.selectedScopeButtonIndex==2){
        preicate = [NSPredicate predicateWithFormat:@"FlightNo BEGINSWITH[c] %@",searchString];
    }else if (self.searchController.searchBar.selectedScopeButtonIndex==3){
        preicate=[NSPredicate predicateWithFormat:@"Price == %d",[searchString intValue]];
    }
    if (searchList != nil) {
        [searchList removeAllObjects];
    }
    // 获取搜索后的数组
    searchList = [NSMutableArray arrayWithArray:[listofFlights filteredArrayUsingPredicate:preicate]];
    
    [self.tableView reloadData];
}
#pragma mark - refresh 操作
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
        self.searchController.active=NO;
    }else if([segue.identifier isEqualToString:@"enterInfo"]){
        enterInfo *info=[[enterInfo alloc] init];
        info=[segue destinationViewController];
    }
}


@end
