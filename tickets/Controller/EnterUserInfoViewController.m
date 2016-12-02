//
//  EnterUserInfoViewController.m
//  tickets
//
//  Created by 李祖翔 on 16/11/22.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "EnterUserInfoViewController.h"

@interface EnterUserInfoViewController ()<UITextFieldDelegate>
{
    NSString *doc;
    NSString *fileName;
    FMDatabase *db;
}
@end

@implementation EnterUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[Database createDataBase:doc filename:fileName];
    [Database createUserFile:doc filename:fileName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitUserInfo:(UIButton *)sender {
    fileName=[Database loadDataBase:doc filename:fileName];
    db = [FMDatabase databaseWithPath:fileName];
    [Database insertUserFileToDataBase:((UITextField*)_userInfo[0]).text UserID:((UITextField*)_userInfo[1]).text UserSex:((UITextField*)_userInfo[2]).text DateOfBirth:((UITextField*)_userInfo[3]).text DataBase:db];
    [self dismissViewControllerAnimated:YES completion:^{
        //[(FlightInfoTableViewController *)self.parentViewController refresh];
    }];
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
