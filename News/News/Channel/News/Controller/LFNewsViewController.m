//
//  LFNewsViewController.m
//  News
//
//  Created by 刘健 on 16/2/29.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFNewsViewController.h"
#import "LFNewsModel.h"
#import "LFNewsViewCell.h"
#import "SDRefresh.h"
#import "LFDigestViewController.h"
@interface LFNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) NSArray *datas;

@property(nonatomic,strong) SDRefreshHeaderView *headerView;

@property(nonatomic,strong) SDRefreshFooterView *footerView;
@property(nonatomic,assign) NSInteger page;
@end

@implementation LFNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    //下拉刷新
    self.headerView = [SDRefreshHeaderView refreshView];
    [self.headerView addToScrollView:self.tableView];
    __weak typeof (self) weakSelf = self;
    [self.headerView setBeginRefreshingOperation:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.page = 0;
            [weakSelf loadData];
            [weakSelf.tableView reloadData];
            [weakSelf.headerView endRefreshing];
        });
    }];
    
    //上拉
    self.footerView = [SDRefreshFooterView refreshView];
    [self.footerView addToScrollView:self.tableView];
    [self.footerView setBeginRefreshingOperation:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weakSelf.page += 5;
            [weakSelf loadData];
            [weakSelf.tableView reloadData];
            [weakSelf.footerView endRefreshing];
        });
    }];
    
    
}

//加载数据
- (void)loadData {
    NSLog(@"%@",self.channelId);
    [LFNewsModel newsDataWithURL:[NSString stringWithFormat:@"article/headline/%@/%zd-20.html",self.channelId,self.page] success:^(NSArray * result) {
        self.datas = result;
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LFNewsModel * newsModel = self.datas[indexPath.row];
    
    NSString * ID = [LFNewsViewCell cellIdentifierWithModel:newsModel];
    
    LFNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
   
    cell.newsModel = newsModel;
    
    return cell;
    
}

//返回cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     LFNewsModel * newsModel = self.datas[indexPath.row];
    return [LFNewsViewCell cellHeightWithModel:newsModel];
}

//push控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LFNewsModel * newsModel = self.datas[indexPath.row];
    LFDigestViewController * digestController = [[LFDigestViewController alloc]init];
    digestController.fullURL = newsModel.fullURl;
    [self.navigationController pushViewController:digestController animated:YES];
}
@end
