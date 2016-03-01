//
//  LFChannelViewController.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFChannelViewController.h"
#import "LFChannelModel.h"
#import "LFchannelViewCell.h"
#import "LFNewsViewController.h"
#import "XWCatergoryView.h"
@interface LFChannelViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property(nonatomic,strong) NSArray *channels;

//缓存池
@property(nonatomic,strong) NSMutableDictionary *channelCaches;
//当前页下标
@property(nonatomic,assign) NSInteger currentPage;


//保存label数组

@property(nonatomic,strong) NSArray * titles;


@end

@implementation LFChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar64"]];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];  
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setup];
    [self channelScrollView];
}

//导航栏
- (void)channelScrollView {
    
    //catergoryView
    XWCatergoryView * catergoryView = [XWCatergoryView new];
    catergoryView.titles = self.titles;
    catergoryView.scrollView = self.collectionView;
//    catergoryView.delegate = self;
    catergoryView.titleColor = [UIColor blackColor];
    catergoryView.itemSpacing = 18;
    catergoryView.edgeSpacing = 8;
    /**开启背后椭圆*/
    catergoryView.scaleEnable = YES;
    //设置缩放等级
    catergoryView.scaleRatio = 1.2;
    //开启点击item滑动scrollView的动画
    catergoryView.scrollWithAnimaitonWhenClicked = YES;;
    [self.scrollView addSubview:catergoryView];
    catergoryView.frame = self.scrollView.bounds;
    //frame;
//    [catergoryView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(self.view.mas_top).offset(64);
//        make.height.equalTo(@50);
//        make.bottom.equalTo(self.collectionView.mas_top);
//    }];

}

//collectionView属性
- (void) setup {
    
    self.layout.itemSize = self.collectionView.bounds.size;
    self.layout.minimumLineSpacing = 0;
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    
}

- (void)loadData {
    
    NSArray * datas = [LFChannelModel loadLocalWord];
    
//    //OC排序
    datas = [datas sortedArrayUsingComparator:^NSComparisonResult(LFChannelModel *  _Nonnull obj1, LFChannelModel *   _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
//    __block CGFloat labelX = 0;
    NSMutableArray *arr = [NSMutableArray array];
    [datas enumerateObjectsUsingBlock:^(LFChannelModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       [arr addObject:obj.tname];
        
    }];
    self.titles = arr;
    
//    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    self.channels = datas;
    [self.collectionView reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LFchannelViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LFchannelViewCell" forIndexPath:indexPath];
    
    //把旧的news.view 删除 防止控制器叠加
    [cell.newsController.view removeFromSuperview];
    
    LFChannelModel * model = self.channels[indexPath.item];
    
    LFNewsViewController * news = [self loadNewsControllerWith:model];
//    强引用子控器，否则影响响应链条
    if (![self.childViewControllers containsObject:news]) {
        [self addChildViewController:news];
    }
    news.view.frame = cell.contentView.bounds;
    
    self.title = model.tname;
    
    [cell.contentView addSubview:news.view];
    
    return cell;
}
#pragma mark  --计算label缩放比例




#pragma mark -- 加载控制器
- (LFNewsViewController *)loadNewsControllerWith:(LFChannelModel *)model {
    
    LFNewsViewController * news = [self.channelCaches objectForKey:model.tname];
    //    NSLog(@"news==%@",news);
    if (news == nil) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        news = sb.instantiateInitialViewController;
        news.channelId = model.tid;
        [self.channelCaches setObject:news forKey:model.tname];
        //        NSLog(@"self==%@",self.channelCaches);
    }
    
    return news;
}

#pragma mark --懒加载
- (NSMutableDictionary *)channelCaches {
    if (_channelCaches == nil) {
        _channelCaches = [NSMutableDictionary dictionary];
    }
    return _channelCaches;
}



@end
