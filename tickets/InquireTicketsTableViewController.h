//
//  InquireTicketsTableViewController.h
//  tickets
//
//  Created by 李祖翔 on 2016/11/13.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InquireTicketsTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *dataList; // 保存假数据
@property (strong, nonatomic) NSMutableArray *searchList; // 保存搜索数据
@property (strong, nonatomic) UISearchController *searchController;
@end
