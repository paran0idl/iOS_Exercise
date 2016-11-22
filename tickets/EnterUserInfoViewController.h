//
//  EnterUserInfoViewController.h
//  tickets
//
//  Created by 李祖翔 on 16/11/22.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database.h"
@interface EnterUserInfoViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *userInfo;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
