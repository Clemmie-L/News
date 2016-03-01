//
//  LFHeaderModel.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFHeaderModel.h"
#import "LFHTTPManager.h"
#import <YYModel.h>
@implementation LFHeaderModel


+ (void)headerDataWithURL: (NSString *)url success: (void(^)(id result))success {
    
    [[LFHTTPManager sharedManager]GET_dataWithURLPath: url success:^(NSDictionary * result) {
//        NSLog(@"%@",result);
        NSString * key = result.keyEnumerator.nextObject;
//        NSLog(@"%@",key);
        NSArray * datas = [NSArray yy_modelArrayWithClass:self json: result[key]];
//        NSLog(@"%@",datas);
        success(datas);
        
    } failure:^(NSError *error) {
        success(nil);
    }];
}
@end
