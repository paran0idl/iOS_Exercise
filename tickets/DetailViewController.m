//
//  DetailViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/12.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "DetailViewController.h"
@interface DetailViewController ()
@end

@implementation DetailViewController
@synthesize flightInfo,DCity,ACity,DTime,ATime,AirPlaneNo,FlightNo,LeftTotalT,APrice,DisPrice;
- (void)viewDidLoad {
    [super viewDidLoad];
    DCity.text=[flightInfo valueForKey:@"DCity"];
    ACity.text=[flightInfo valueForKey:@"ACity"];
    DTime.text=[flightInfo valueForKey:@"DTime"];
    ATime.text=[flightInfo valueForKey:@"ATime"];
    AirPlaneNo.text=[flightInfo valueForKey:@"AirPlaneNo"];
    FlightNo.text=[flightInfo valueForKey:@"FlightNo"];
    //APrice.text=[flightInfo valueForKey:@"Price"];
    APrice.text=[NSString stringWithFormat:@"￥%@",[flightInfo valueForKey:@"Price"]];
    DisPrice.text=[NSString stringWithFormat:@"￥%@",[flightInfo valueForKey:@"DisPrice"]];
    LeftTotalT.text=[NSString stringWithFormat:@"%@/%@",[flightInfo valueForKey:@"LeftT"],[flightInfo valueForKey:@"TotalT"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
