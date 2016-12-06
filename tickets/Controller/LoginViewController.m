//
//  LoginViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/12/3.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    NSString *fileName;
    NSString *doc;
    FMDatabase *db;
    NSMutableArray *listofLogin;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[Database loadDataBase:doc filename:fileName];
    db=[FMDatabase databaseWithPath:fileName];
    listofLogin=[self addObjectWithLogin];
    //view init
    _usernameTextField.delegate=self;
    _passwordTextField.delegate=self;
    _passwordTextField.secureTextEntry=YES;
    self.loginButton.layer.cornerRadius=7;
    self.registerButton.layer.cornerRadius=7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)addObjectWithLogin{
    db = [FMDatabase databaseWithPath:fileName];
    [db open];
    FMResultSet *resultSet = [db executeQuery:@"select * from Login"];
    NSMutableArray *searchResult;
    searchResult=[[NSMutableArray alloc] init];
    
    while ([resultSet  next])
    {
        [searchResult addObject:[resultSet resultDictionary]];
    }
    [db close];
    return searchResult;
}
-(BOOL)isLoginValid:(NSString*)Username Password:(NSString*)Password{
    for(NSDictionary *dict in listofLogin){
        if([[dict valueForKey:@"Username"] isEqualToString:Username]&&[[dict valueForKey:@"Password"] isEqualToString:Password]){
            return TRUE;
        }
    }
    return FALSE;
}
- (IBAction)loginButtonPress:(UIButton *)sender {
    if([self isLoginValid:self.usernameTextField.text Password:self.passwordTextField.text]){
        NSLog(@"YES");
        [self performSegueWithIdentifier:@"login" sender:nil];
    }else{
        UIAlertController *wrong=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Something wrong" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            nil;
        }];
        [wrong addAction:cancel];
        [self presentViewController:wrong animated:YES completion:nil];
        NSLog(@"WRONG");
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
#pragma mark - Navigation



@end
