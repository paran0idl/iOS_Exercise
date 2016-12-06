//
//  enterInfo.m
//  tickets
//
//  Created by 李祖翔 on 2016/11/4.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "enterInfo.h"
#import "FlightInfoTableViewController.h"
@interface enterInfo ()<UITextFieldDelegate>
{
    NSString *doc;
    NSString *fileName;
}
@end

@implementation enterInfo
@synthesize FlightNo,AirplaneNo,DCity,ACity,TotalT,LeftT,Price,DisPrice,DTime,ATime,db;
- (void)viewDidLoad {
    [super viewDidLoad];
    [Database createDataBase:doc filename:fileName];
    FlightNo.delegate=self;
    AirplaneNo.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonPress:(id)sender {
    fileName=[Database loadDataBase:doc filename:fileName];
    db = [FMDatabase databaseWithPath:fileName];
    [Database insertToDataBase:FlightNo.text AirplaneNo:AirplaneNo.text DCity:DCity.text ACity:ACity.text DTime:DTime.text ATime:ATime.text Price:Price.text DisPrice:DisPrice.text TotalT:TotalT.text LeftT:LeftT.text DataBase:db];
    [self dismissViewControllerAnimated:YES completion:^{
        //[(FlightInfoTableViewController *)self.parentViewController refresh];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"return"]){
        FlightInfoTableViewController *vc=[[FlightInfoTableViewController alloc] init];
        vc=[segue destinationViewController];
        [vc refresh];
        
    }
}
*/

@end
