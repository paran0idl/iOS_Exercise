//
//  OrderTicketsTableViewController.h
//  tickets
//
//  Created by 李祖翔 on 16/11/22.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
#import "UserInfoCell.h"
@interface OrderTicketsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak,nonatomic)NSNumber *TicketID;
@property (weak,nonatomic)NSNumber *Seat;
-(NSMutableArray *)addObjectWithUserInfo;
-(void)refresh;  
@end
