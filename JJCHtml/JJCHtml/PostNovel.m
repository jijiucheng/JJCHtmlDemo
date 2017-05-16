//
//  PostNovel.m
//  JJCHtml
//
//  Created by 苜蓿鬼仙 on 2017/5/15.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import "PostNovel.h"
#import "Ono.h"


static NSString *const kUrlString = @"http://www.xquledu.com/html/1/1869/1070951.html";


@implementation PostNovel

//*[@id="amain"]/dl
//*[@id="amain"]/dl/dt/p/a[5]   url
//*[@id="amain"]/dl/dd[1]/h1    title
//*[@id="contents"]             content
+ (instancetype)getNovelDataWithHtmlString:(ONOXMLElement *)element {
    
    PostNovel *post = [PostNovel new];
    
    ONOXMLElement *titleElement = [element firstChildWithXPath:@""];
    post.novelUrl   = [titleElement valueForAttribute:@"dl/dt/p/a[5]/href"];
    post.novelTitle = [titleElement valueForAttribute:@"dl/dd[1]/h1"];
    
    ONOXMLElement *contentElement = [element firstChildWithXPath:@"//*[@id='contents']"];
    post.novelContent = [contentElement stringValue];
    
    return post;
}

//*[@id="amain"]
+ (NSArray *)getNovelData {
    
    NSMutableArray *array = [NSMutableArray array];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kUrlString]];  //下载网页数据
    
    NSError *error;
    ONOXMLDocument *doc = [ONOXMLDocument HTMLDocumentWithData:data error:&error];
    ONOXMLElement *postsParentElement = [doc firstChildWithXPath:@"//*[@id='amain']"];  //寻找该 XPath 代表的 HTML 节点
    // 遍历其子节点
    [postsParentElement.children enumerateObjectsUsingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"----------------- %@", element);
        
        PostNovel *post = [PostNovel getNovelDataWithHtmlString:element];
        
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.novelUrl);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.novelTitle);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.novelTime);
        NSLog(@"--- %lu ---- %@", (unsigned long)idx, post.novelContent);
        NSLog(@"***********************************************************************");
        
        
        NSArray *tempArray = [post.novelContent componentsSeparatedByString:@"    "];

        NSMutableString *tempString = [NSMutableString string];
        for (NSString *string in tempArray) {
            if ([string.lowercaseString rangeOfString:@"xquledu"].location == NSNotFound) {
                [tempString appendString:@"        "];
                [tempString appendFormat:@"%@", [NSString stringWithFormat:@"%@\n\n", string]];
            }
        }
        post.novelContent = tempString;
        
        
        if (post) {
            [array addObject:post];
        }
        
    }];
    

    
    return array;
}




@end
