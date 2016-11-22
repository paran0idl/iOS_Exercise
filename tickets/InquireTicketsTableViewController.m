//
//  InquireTicketsTableViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/13.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "InquireTicketsTableViewController.h"
#import "FlightInfoTableViewController.h"
#import "Database.h"
#import "FlightInfoCell.h"
#import "DetailViewController.h"
@interface InquireTicketsTableViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>
{
    NSString *fileName;
    NSString *doc;
    FMDatabase *db;
}
@end

@implementation InquireTicketsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[[NSString alloc] init];
    doc=[[NSString alloc] init];
    db=[[FMDatabase alloc] init];
    _dataList=[[NSMutableArray alloc] init];
    fileName=[Database loadDataBase:doc filename:fileName];
    _dataList=[self addObjectWithFlightInfo];
    self.searchController.active=YES;
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
    // Dispose of any resources that can be recreated.
}
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
    
        _searchController.searchBar.showsScopeBar=YES;
        _searchController.searchBar.scopeButtonTitles=@[@"D/ACity",@"FlightNo",@"Price"];
    }
    return _searchController;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*
     self.searchController.active active 属性用于判断 searchBar 是否处于活动状态
     */
    if (self.searchController.active) {
        // 返回搜索后的数组
        return [self.searchList count];
    }else {
        
        return 0;
    }
}

- (FlightInfoCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"result";
    FlightInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[FlightInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (self.searchController.active) {
        // 返回搜索后的数组
        cell.DCity.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"DCity"];
        cell.ACity.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"ACity"];
        cell.DTime.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"DTime"];
        cell.ATime.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"ATime"];
        cell.FlightNo.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"FlightNo"];
        cell.AirPlaneNo.text=[[_searchList objectAtIndex:indexPath.row] valueForKey:@"AirplaneNo"];
    }
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    // 获取搜索框文本
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate;
    // 判断数组中是否包含 searchString
    if(self.searchController.searchBar.selectedScopeButtonIndex==0){
        preicate = [NSPredicate predicateWithFormat:@"DCity BEGINSWITH[c] %@",searchString];
    }else if (self.searchController.searchBar.selectedScopeButtonIndex==1){
        preicate = [NSPredicate predicateWithFormat:@"FlightNo BEGINSWITH[c] %@",searchString];
    }else if(self.searchController.searchBar.selectedScopeButtonIndex==2){
        preicate = [NSPredicate predicateWithFormat:@"Price == %d",[searchString intValue]];
    }
    //NSPredicate *preicate = [NSPredicate predicateWithFormat:@"FlightNo BEGINSWITH[c] %@",searchString];
    if (self.searchList != nil) {
        [self.searchList removeAllObjects];
    }
    // 获取搜索后的数组
    self.searchList = [NSMutableArray arrayWithArray:[self.dataList filteredArrayUsingPredicate:preicate]];
    /*for(NSDictionary *dic in _dataList){
        [self.searchList addObject:[[dic allKeys]filteredArrayUsingPredicate:preicate]];
    }*/
    // 刷新表格
    [self.tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"searchResult"]){
        DetailViewController *detail=[[DetailViewController alloc] init];
        detail=[segue destinationViewController];
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        detail.flightInfo=[_searchList objectAtIndex:indexPath.row];
        self.searchController.active=NO;
    }
}

@end
