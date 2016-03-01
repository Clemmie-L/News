//
//  LFNewsViewCell.h
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LFNewsModel;
@interface LFNewsViewCell : UITableViewCell

@property(nonatomic,strong) LFNewsModel *newsModel;
//返回不同的cell
+ (NSString *)cellIdentifierWithModel:(LFNewsModel *)model;
//返回不同的cell的高度
+ (CGFloat)cellHeightWithModel:(LFNewsModel *)model;
@end
