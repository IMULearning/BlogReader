//
//  BlogPost.m
//  BlogReader2
//
//  Created by Weinan Qiu on 2014-10-11.
//  Copyright (c) 2014 Eland. All rights reserved.
//

#import "BlogPost.h"

#define DATE_INPUT_FORMAT "yyyy-MM-dd hh:mm:ss"
#define DATE_OUTPUT_FORMAT "EE MMM, dd"

@implementation BlogPost

+ (id) blogPostWithTitle : (NSString *) title
                  Author : (NSString *) author {
    return [[self alloc] initWithTitle:title Author:author];
}

- (id) initWithTitle: (NSString *) title Author: (NSString *) author {
    self = [super init];
    
    if (self) {
        self.title = title;
        self.author = author;
        self.thumbnail = nil;
        self.url = nil;
    }
    
    return self;
}

- (NSString *) formattedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    if (!self.date) {
        return nil;
    } else {
        [formatter setDateFormat:@DATE_INPUT_FORMAT];
        NSDate *tempDate = [formatter dateFromString:self.date];
        [formatter setDateFormat:@DATE_OUTPUT_FORMAT];
        return [formatter stringFromDate:tempDate];
    }
}

@end
