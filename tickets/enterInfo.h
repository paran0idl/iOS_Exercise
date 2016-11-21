//
//  enterInfo.h
//  tickets
//
//  Created by 李祖翔 on 2016/11/4.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "ViewController.h"
#import "Database.h"
@interface enterInfo : ViewController
@property (weak, nonatomic) IBOutlet UITextField *FlightNo;
@property (weak, nonatomic) IBOutlet UITextField *AirplaneNo;
@property (weak, nonatomic) IBOutlet UITextField *DCity;
@property (weak, nonatomic) IBOutlet UITextField *ACity;
@property (weak, nonatomic) IBOutlet UITextField *TotalT;
@property (weak, nonatomic) IBOutlet UITextField *LeftT;
@property (weak, nonatomic) IBOutlet UITextField *Price;
@property (weak, nonatomic) IBOutlet UITextField *DisPrice;
@property (weak, nonatomic) IBOutlet UITextField *DTime;
@property (weak, nonatomic) IBOutlet UITextField *ATime;

@property (weak, nonatomic) IBOutlet UIButton *submitInfo;

//@property (nonatomic, retain) NSString * doc;
//@property (nonatomic, retain) NSString *fileName;
@property(nonatomic)FMDatabase* db;
@end
