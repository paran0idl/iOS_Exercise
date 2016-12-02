//
//  FlightInfoTableViewController.h
//  
//
//  Created by 李祖翔 on 2016/11/10.
//
//

#import <UIKit/UIKit.h>

@interface FlightInfoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (strong, nonatomic) UISearchController *searchController;
-(NSMutableArray *)addObjectWithFlightInfo;
-(void)refresh;                                                                                                                                                                                                                                                                
@end
