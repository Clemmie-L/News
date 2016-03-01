//
//  LFChannelModel.h
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFChannelModel : NSObject


@property(nonatomic,copy) NSString *tname;

@property(nonatomic,copy) NSString *tid;

//加载本地文件 加载Json
+ (NSArray *)loadLocalWord;
@end
