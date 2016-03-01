//
//  LFNewsModel.h
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFNewsModel : NSObject
//标题
@property(nonatomic,copy) NSString *title;
//跟帖数
@property(nonatomic,copy) NSString *replyCount;
//照片
@property(nonatomic,copy) NSString *imgsrc;
//详细内容
@property(nonatomic,copy) NSString *digest;
//类型是1，是大图，其他是小图
@property(nonatomic,assign) NSInteger imgType;
//多个图片
@property(nonatomic,strong) NSArray *imgextra;
//跳转内容ID
@property(nonatomic,copy) NSString *docid;
//全地址
@property(nonatomic,copy) NSString *fullURl;

//获取URl数据
+ (void)newsDataWithURL: (NSString *)url success: (void(^)(id result))success;

@end
