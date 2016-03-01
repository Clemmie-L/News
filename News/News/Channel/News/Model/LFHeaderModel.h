//
//  LFHeaderModel.h
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LFHeaderModel : NSObject


@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *imgsrc;

+ (void)headerDataWithURL: (NSString *)url success: (void(^)(id result))success;

@end
