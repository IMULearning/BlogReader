//
//  WebViewController.h
//  BlogReader2
//
//  Created by Weinan Qiu on 2014-10-11.
//  Copyright (c) 2014 Eland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSURL *blogPostURL;

@end
