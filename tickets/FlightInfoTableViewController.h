//
//  FlightInfoTableViewController.h
//  
//
//  Created by 李祖翔 on 2016/11/10.
//
//

#import <UIKit/UIKit.h>
typedef void(^returnDataBlock)(NSDictionary *flightInfo);

@interface FlightInfoTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property(nonatomic,copy)returnDataBlock returnDataBlock;
//@property(nonatomic,weak)NSMutableArray* listofFlights;

-(NSMutableArray *)addObjectWithFlightInfo;
-(void)returnData:(returnDataBlock)DataBlock;
-(void)refresh;                                                                                                                                                                                                                                                                
@end
