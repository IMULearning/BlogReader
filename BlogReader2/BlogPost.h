//
//  BlogPost.h
//  BlogReader2
//
//  Created by Weinan Qiu on 2014-10-11.
//  Copyright (c) 2014 Eland. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface BlogPost : NSObject

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *author;
@property(nonatomic, strong) UIImage *thumbnail;
@property(nonatomic, strong) NSString *date;
@property(nonatomic, strong) NSURL *url;

- (id) initWithTitle : (NSString *) title
              Author : (NSString *) author;

+ (id) blogPostWithTitle : (NSString *) title
                  Author : (NSString *) author;

- (NSString *) formattedDate;

@end
