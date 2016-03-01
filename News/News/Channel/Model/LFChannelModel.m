//
//  LFChannelModel.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFChannelModel.h"
#import <YYModel.h>
@implementation LFChannelModel

+ (NSArray *)loadLocalWord {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary * dict = [NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
    
    NSString *key = dict.keyEnumerator.nextObject;
    
    return [NSArray yy_modelArrayWithClass:self json:dict[key]];
  }

@end
