//
//  LFDigestViewController.m
//  News
//
//  Created by 刘健 on 16/3/1.
//  Copyright © 2016年 Clemmie. All rights reserved.
//

#import "LFDigestViewController.h"
#import "LFHTTPManager.h"

@interface LFDigestViewController ()<UIWebViewDelegate>


@property(nonatomic,strong) UIWebView *webView;


@property(nonatomic,copy) NSString *body;

@property(nonatomic,copy) NSString *time;

@property(nonatomic,copy) NSString *ltitle;
@end

@implementation LFDigestViewController

- (void)loadView {
    self.webView = [[UIWebView alloc]init];
    self.view = self.webView;
    self.webView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}
//加载数据
- (void)loadData {
    
    NSLog(@"%@",self.fullURL);
    [[LFHTTPManager sharedManager]GET_dataWithURLPath:self.fullURL success:^(NSDictionary * result) {
        NSString * key = result.keyEnumerator.nextObject;
        NSDictionary * datas = result[key];
        NSLog(@"%@",datas);
        __block NSString * body = datas[@"body"];
        NSLog(@"%@",body);
        NSArray * img = datas[@"img"];
        //照片替换字符串
        [img enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString * ref = obj[@"ref"];
          body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHTMLWithDict:obj]];
        }];
        
        NSArray * video = datas[@"video"];
          [video enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              NSString * ref = datas[@"ref"];
              body = [body stringByReplacingOccurrencesOfString:ref withString:[self videoHTMLWithDict:obj]];
          }];
        self.body = body;
        self.ltitle = datas[@"title"];
        self.time = [NSString stringWithFormat:@"%@  %@",datas[@"ptime"],datas[@"source"]];
        
        //请求数据
        NSURL * url = [[NSBundle mainBundle]URLForResource:@"detail.html" withExtension:nil];
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (NSString *)imageHTMLWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"  alt=\"%@\"/><span style=\"font-size: 13px;color: dimgrey\">%@</span>",dict[@"src"],dict[@"alt"],dict[@"alt"]];
    return html;
}

- (NSString *)videoHTMLWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<video width=\"100%%\" controls>"
                      "<source src=\"%@\""
                      " type=\"video/mp4\">"
                      "您的浏览器不支持 HTML5 video 标签。"
                      "</video><span style=\"font-size: 13px;color: dimgrey\">%@</span>",dict[@"url_mp4"],dict[@"alt"]];
    return html;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString * code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.ltitle,self.time,self.body];
    [webView stringByEvaluatingJavaScriptFromString:code];
}
@end
