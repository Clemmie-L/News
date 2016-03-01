//
//  LFHTTPManager.h
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface LFHTTPManager :  AFHTTPSessionManager


+ (instancetype)sharedManager;

//自定义网络api
- (void)GET_dataWithURLPath:(NSString *)url  success:(void(^)(id result))success failure:(void (^)( NSError * error))failure;
@end
