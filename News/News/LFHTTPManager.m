//
//  LFHTTPManager.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFHTTPManager.h"

#define LFBaseURL [NSURL URLWithString:@"http://c.m.163.com/nc/"]
@implementation LFHTTPManager

//单例获取网络数据
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static LFHTTPManager *instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]initWithBaseURL:LFBaseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    return instance;
}

- (void)GET_dataWithURLPath:(NSString *)url  success:(void (^)(id result))success failure:(void (^)(NSError * error))failure {
    NSAssert(success != nil, @"回调不能为空");
    [[LFHTTPManager sharedManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
}
@end

