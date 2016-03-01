//
//  LFHeaherViewController.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFHeaherViewController.h"
#import "LFHeaderModel.h"
#import "SDCycleScrollView.h"

@interface LFHeaherViewController ()<SDCycleScrollViewDelegate>

//图片滚动
@property(nonatomic,strong) SDCycleScrollView *cycleScrollView2;

@end

@implementation LFHeaherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        [self loadData];
    
    self.cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 230) delegate:self placeholderImage:nil];
    [self.view addSubview:self.cycleScrollView2];
    self.cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleScrollView2.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    //清理缓存
    [SDCycleScrollView clearImagesCache];
    
}

- (void)loadData {
   
    NSMutableArray *arrtitles = [NSMutableArray array];
    NSMutableArray *arrImgs = [NSMutableArray array];
    [LFHeaderModel headerDataWithURL:@"ad/headline/0-4.html" success:^(NSArray * result) {
    
        [result enumerateObjectsUsingBlock:^(LFHeaderModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //            NSLog(@"%@",obj);
            [arrtitles addObject:obj.title];
            
            [arrImgs addObject:obj.imgsrc];
            
        }];
        self.cycleScrollView2.titlesGroup = arrtitles;
        //加载图片
        self.cycleScrollView2.imageURLStringsGroup = arrImgs;
    }];

    
    
    
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

#pragma mark --懒加载
//- (NSArray *)imgs {
//    if (_imgs == nil) {
//        _imgs = [NSArray array];
//    }
//    return _imgs;
//}
//
//- (NSArray *)titles {
//    if (_titles == nil) {
//        _titles = [NSArray array];
//    }
//    return _titles;
//}
@end
