//
//  LoginViewController.h
//  tickets
//
//  Created by 李祖翔 on 2016/12/3.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
