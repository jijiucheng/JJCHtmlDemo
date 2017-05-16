//
//  HtmlModel.m
//  JJCHtml
//
//  Created by 苜蓿鬼仙 on 2017/5/15.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "Post.h"
#import "Ono.h"


static NSString *const kUrlStr = @"http://swift.gg/page/17/";


@implementation Post

+ (NSArray *)getNewPosts {
    
    NSMutableArray *array = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrlStr]];  //下载网页数据
    
    NSError *error;
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ONOXMLElement *postsParentElement = [doc firstChildWithXPath:@"//*[@id='main']"];  //寻找该 XPath 代表的 HTML 节点
    // 遍历其子节点
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"element ----------- %@", element);
        
        Post *post = [Post postWithHtmlStr:element];
        
        NSLog(@"--- %lu ---- %@%@", (unsigned long)idx, @"http://swift.gg",post.url);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.title);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.date);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.introduce);
        NSLog(@"***********************************************************************");
        
        if (post) {
            [array addObject:post];
        }
    }];
    
    return array;
}


//*[@id="main"]/article[1]/div/p[2]
+ (instancetype)postWithHtmlStr:(ONOXMLElement *)element {
    
    Post *p = [Post new];
    
    ONOXMLElement *titleElement = [element firstChildWithXPath:@"header/h1/a"];
    p.url = [titleElement valueForAttribute:@"href"];
    p.title = [titleElement valueForAttribute:@"title"];
    
    ONOXMLElement *dateElement = [element firstChildWithXPath:@"header/p/time"];
    p.date = [dateElement stringValue];
    
    ONOXMLElement *introduceElement = [element firstChildWithXPath:@"div/p[2]"];
    p.introduce = [introduceElement stringValue];
    
    return p;
}

//- (void)setUrl:(NSString *)url {
//    _url = [kUrlStr stringByAppendingString:url];
//}

@end









