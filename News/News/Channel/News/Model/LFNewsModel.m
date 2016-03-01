//
//  LFNewsModel.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFNewsModel.h"
#import "LFHTTPManager.h"
#import <YYModel.h>
@implementation LFNewsModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"imgextra" : [LFNewsModel class],};
}

+ (void)newsDataWithURL: (NSString *)url success: (void(^)(id result))success {
    
    [[LFHTTPManager sharedManager]GET_dataWithURLPath: url success:^(NSDictionary * result) {
        //        NSLog(@"%@",result);
        NSString * key = result.keyEnumerator.nextObject;
        //        NSLog(@"%@",key);
        NSArray * datas = [NSArray yy_modelArrayWithClass:self json: result[key]];
//                NSLog(@"%@",datas);
        success(datas);
        
    } failure:^(NSError *error) {
        success(nil);
    }];
}


- (void)setDocid:(NSString *)docid {
    _docid = docid;
    self.fullURl = [NSString stringWithFormat:@"article/%@/full.html",docid];
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    
//}
@end
