//
//  RegisterViewController.m
//  tickets
//
//  Created by 李祖翔 on 2016/12/3.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSString *fileName;
    NSString *doc;
    FMDatabase *db;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    fileName=[Database loadDataBase:doc filename:fileName];
    db=[FMDatabase databaseWithPath:fileName];
    _registerButton.layer.cornerRadius=7.5;
    _usernameTextField.delegate=self;
    _passwordTextField.delegate=self;
    _confirmPasswordTextField.delegate=self;
    _passwordTextField.secureTextEntry=YES;
    _confirmPasswordTextField.secureTextEntry=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldNotEmpty{
    if(self.usernameTextField.text.length>0&&
       self.passwordTextField.text.length>0&&self.confirmPasswordTextField.text.length>0)
    {
        return TRUE;
    }else{
        return FALSE;
    }
}
-(BOOL)passwordConfirmed{
    if([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]){
        return TRUE;
    }else{
        return FALSE;
    }
}
- (IBAction)registerButtonPress:(UIButton *)sender {
    if([self textFieldNotEmpty]&&[self passwordConfirmed]){
        [Database insertLoginFileToDataBase:self.usernameTextField.text Password:self.passwordTextField.text DataBase:db];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        UIAlertController *wrong=[UIAlertController alertControllerWithTitle:@"Alert" message:@"Something wrong" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            nil;
        }];
        [wrong addAction:cancel];
        [self presentViewController:wrong animated:YES completion:nil];
    }
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
