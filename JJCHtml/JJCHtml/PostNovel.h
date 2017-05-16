//
//  PostNovel.h
//  JJCHtml
//
//  Created by 苜蓿鬼仙 on 2017/5/15.
//  Copyright © 2017年 苜蓿鬼仙. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ONOXMLElement;

@interface PostNovel : NSObject

@property (nonatomic, copy) NSString *novelTitle;
@property (nonatomic, copy) NSString *novelContent;
@property (nonatomic, copy) NSString *novelUrl;
@property (nonatomic, copy) NSString *novelTime;


+ (instancetype)getNovelDataWithHtmlString:(ONOXMLElement *)element;
+ (NSArray *)getNovelData;


@end
