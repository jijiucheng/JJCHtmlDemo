//
//  ViewController.m
//  JJCHtml
//
//  Created by 苜蓿鬼仙 on 2017/5/15.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"
#import "Post.h"
#import "PostNovel.h"


@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createUI];
    [self getHtmlData];
}


- (void)getHtmlData {
    
//    [Post getNewPosts];
    _dataArray = [PostNovel getNovelData];
    
    PostNovel *model = _dataArray[0];
    _label.text = model.novelContent;
    
    
    _scrollView.contentSize = [ViewController base_getContentSize:_label.text withFontSize:18 andWidth:self.view.frame.size.width];
    _label.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
}

- (void)createUI {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    _label.backgroundColor = [UIColor lightGrayColor];
    _label.text = @"";
    _label.textColor = [UIColor blackColor];
    _label.font = [UIFont systemFontOfSize:18];
    _label.numberOfLines = 0;
    [_scrollView addSubview:_label];
    
    
    
}


+ (CGSize)base_getContentSize:(NSString *)content withFontSize:(float )fontSize andWidth:(float)width{
    if(content == nil || [content isEqualToString:@""]) return CGSizeMake(0.0, 0.0);
    UIFont * font = [UIFont systemFontOfSize:fontSize];
    CGSize contentSize = [content boundingRectWithSize: CGSizeMake(width, MAXFLOAT) // 用于计算文本绘制时占据的矩形块
                                               options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading        // 文本绘制时的附加选项
                                            attributes: @{ NSFontAttributeName: font }   // 文字的属性
                                               context: nil].size;
    return contentSize;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
