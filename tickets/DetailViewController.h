//
//  DetailViewController.h
//  tickets
//
//  Created by 李祖翔 on 2016/11/12.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "ViewController.h"

@interface DetailViewController : ViewController


@property (weak, nonatomic) IBOutlet UILabel *DCity;
@property (weak, nonatomic) IBOutlet UILabel *ACity;
@property (weak, nonatomic) IBOutlet UILabel *ATime;
@property (weak, nonatomic) IBOutlet UILabel *DTime;
@property (weak, nonatomic) IBOutlet UILabel *FlightNo;
@property (weak, nonatomic) IBOutlet UILabel *AirPlaneNo;
@property (weak, nonatomic) IBOutlet UILabel *APrice;
@property (weak, nonatomic) IBOutlet UILabel *DisPrice;
@property (weak, nonatomic) IBOutlet UILabel *LeftTotalT;
@property(weak,nonatomic)NSDictionary *flightInfo;


@end
