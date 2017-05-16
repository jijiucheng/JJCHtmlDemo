//
//  HtmlModel.h
//  JJCHtml
//
//  Created by 苜蓿鬼仙 on 2017/5/15.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ONOXMLElement;

@interface Post : NSObject

@property (nonatomic, copy) NSString *title;      // 标题
@property (nonatomic, copy) NSString *introduce;  // 简介
@property (nonatomic, copy) NSString *date;       // 时间
@property (nonatomic, copy) NSString *url;        // url


+ (NSArray *)getNewPosts;  // 获取所有文章目录
+ (instancetype)postWithHtmlStr:(ONOXMLElement *)element;  // 用 HTML 数据创建


@end
