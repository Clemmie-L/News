//
//  LFNewsViewCell.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFNewsViewCell.h"
#import <UIImageView+WebCache.h>
#import "LFNewsModel.h"
@interface LFNewsViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextraView;

@end

@implementation LFNewsViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setNewsModel:(LFNewsModel *)newsModel {
    _newsModel = newsModel;
   [self.iconView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.titleLabel.text = newsModel.title;
    self.digestLabel.text = newsModel.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@跟帖",newsModel.replyCount];
    
    if (newsModel.imgextra != nil) {
        [self.imgextraView enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //取出数据
            LFNewsModel * model = newsModel.imgextra[idx];
            [obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        }];
    }
 
}

+ (NSString *)cellIdentifierWithModel:(LFNewsModel *)model {
    NSString * ID;
    if ((int)model.imgType == 1) {
        ID = @"LFNewsBigViewCell";
    }else if(model.imgextra != nil) {
        ID = @"LFNewsMoreViewCell";
    }else {
        ID = @"LFNewsViewCell";
    }
    return ID;
}
+ (CGFloat)cellHeightWithModel:(LFNewsModel *)model {
    CGFloat  height;
    if ((int)model.imgType == 1) {
        height = 140;
    }else if(model.imgextra != nil) {
        height = 140;
    }else {
        height = 100;
    }
    return height;
}
@end
