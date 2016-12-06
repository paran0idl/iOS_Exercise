//
//  DetailViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/12.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "DetailViewController.h"
#import "OrderTicketsTableViewController.h"
@interface DetailViewController ()
@end

@implementation DetailViewController
@synthesize flightInfo,DCity,ACity,DTime,ATime,AirPlaneNo,FlightNo,LeftTotalT,APrice,DisPrice,FirstLeft,Date;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.opaque=NO;
    self.OrderButton.layer.cornerRadius=7.5;
    int leftT=[[flightInfo valueForKey:@"LeftT"]intValue];
    DCity.text=[flightInfo valueForKey:@"DCity"];
    ACity.text=[flightInfo valueForKey:@"ACity"];
    DTime.text=[flightInfo valueForKey:@"DTime"];
    ATime.text=[flightInfo valueForKey:@"ATime"];
    AirPlaneNo.text=[flightInfo valueForKey:@"AirPlaneNo"];
    FlightNo.text=[flightInfo valueForKey:@"FlightNo"];
    APrice.text=[NSString stringWithFormat:@"￥%@",[flightInfo valueForKey:@"Price"]];
    DisPrice.text=[NSString stringWithFormat:@"￥%@",[flightInfo valueForKey:@"DisPrice"]];
    LeftTotalT.text=[NSString stringWithFormat:@"%@/%@",[flightInfo valueForKey:@"LeftT"],[flightInfo valueForKey:@"TotalT"]];
    FirstLeft.text=[NSString stringWithFormat:@"剩余头等舱:%@",[flightInfo valueForKey:@"FirstSeat"]];
    Date.text=[NSString stringWithFormat:@"%@",[flightInfo valueForKey:@"Date"]];
    NSLog(@"%@",[flightInfo valueForKey:@"id"]);
    if(leftT==0){
        _OrderButton.enabled=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ToUserInfo"]){
        UINavigationController *nav=[segue destinationViewController];
        OrderTicketsTableViewController *view=[[OrderTicketsTableViewController alloc] init];
        view=nav.topViewController;
        NSNumber *id=[NSNumber numberWithInt:[[flightInfo valueForKey:@"id"]intValue]];
        NSNumber *seat=[NSNumber numberWithInt:[[flightInfo valueForKey:@"TotalT"] intValue]-[[flightInfo valueForKey:@"LeftT"] intValue]];
        NSNumber *Price=[NSNumber numberWithInt:[[flightInfo valueForKey:@"Price"]intValue]];
        NSNumber *DPrice=[NSNumber numberWithInt:[[flightInfo valueForKey:@"DisPrice"]intValue]];
        view.TicketID=id;
        view.Seat=seat;
        view.Price=Price;
        view.DisPrice=DPrice;
    }
}


@end
