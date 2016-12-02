//
//  FreeUpgrade.m
//  tickets
//
//  Created by 李祖翔 on 16/11/30.
//  Copyright © 2016年 李祖翔. All rights reserved.
//

#import "FreeUpgrade.h"

@implementation FreeUpgrade
+(BOOL)FreeUpgrade:(int)leftFirst Current:(int)current All:(int)all{
    NSMutableArray *arr;
    for(int i=1;i<all;i++){
        [arr addObject:[NSNumber numberWithInt:i]];
    }
    for(int i=1;i<leftFirst;i++){
        int tmp;
        [self process:8 array:arr];
        tmp=[[arr firstObject] intValue];
        if(tmp==current){
            return YES;
        }else{
            [arr removeObjectAtIndex:0];
        }
    }
    return NO;
}
+(void)process:(int) p array:(NSMutableArray*)arr{
    for(int i=1;i<p;i++){
        int tmp;
        tmp=[[arr firstObject] intValue];
        [arr removeObjectAtIndex:0];
        [arr addObject:[NSNumber numberWithInt:tmp]];
    }
}
@end
