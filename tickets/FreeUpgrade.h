//
//  FreeUpgrade.h
//  tickets
//
//  Created by 李祖翔 on 16/11/30.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FreeUpgrade : NSObject
+(BOOL)FreeUpgrade:(int)leftFirst Current:(int)current All:(int)all;
+(void)process:(int) p array:(NSMutableArray*)arr;
@end
