//
//  ViewController.m
//  WKWebView
//
//  Created by CSX on 2017/3/31.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKNavigationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
//    config.preferences.minimumFontSize = 18;
    
    WKWebView *webKit = [[WKWebView alloc]initWithFrame:self.view.frame];
    
//    webKit.UIDelegate = self;
    
    webKit.navigationDelegate = self;
    [self.view addSubview:webKit];
    
//    [webKit loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zongs2" ofType:@"html"];//获取文件夹路径
    NSURL *fileURL = [self fileURLForBuggyWKWebView8:[NSURL fileURLWithPath:path]];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:[NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"www/zongs2.html"]] encoding:NSUTF8StringEncoding error:nil];//获取文件路径，现在html的文件路径已经改了。

    //加载本地html文件
    [webKit loadHTMLString:htmlString baseURL:fileURL];
    
    
}
//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL {
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error]) {
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager= [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL withIntermediateDirectories:YES attributes:nil error:&error];
    
    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@">>>>>>>>>>>>>>>>%@",navigation);
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
 WKWebView有很多明显优势:

 更多的支持HTML5的特性
 官方宣称的高达60fps的滚动刷新率以及内置手势
 将UIWebViewDelegate与UIWebView拆分成了14类与3个协议,以前很多不方便实现的功能得以实现。文档
 Safari相同的JavaScript引擎
 占用更少的内存
 */








@end
