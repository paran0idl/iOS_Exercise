//
//  ReservedTicketCell.h
//  tickets
//
//  Created by 李祖翔 on 2016/11/27.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReservedTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DCity;
@property (weak, nonatomic) IBOutlet UILabel *ACity;
@property (weak, nonatomic) IBOutlet UILabel *DateAndTime;
@property (weak, nonatomic) IBOutlet UILabel *FlightAndAirplane;
@property (weak, nonatomic) IBOutlet UILabel *Price;
@property (weak, nonatomic) IBOutlet UILabel *Name;
@property (weak, nonatomic) IBOutlet UILabel *ID;
@property (weak, nonatomic) IBOutlet UILabel *Level;

@property (weak, nonatomic) IBOutlet UIButton *RefundButton;


@end
