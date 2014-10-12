//
//  TableViewController.m
//  BlogReader2
//
//  Created by Weinan Qiu on 2014-10-09.
//  Copyright (c) 2014 Eland. All rights reserved.
//

#import "TableViewController.h"
#import "WebViewController.h"
#import "BlogPost.h"

#define BLOG_POST_RAW_DATA "http://blog.teamtreehouse.com/api/get_recent_summary"
#define DFLT_THUMBNAIL_NAME "logo"
#define KEY_POSTS "posts"
#define KEY_POST_TITLE "title"
#define KEY_POST_AUTHOR "author"
#define KEY_POST_DATE "date"
#define KEY_POST_THUMBNAIL "thumbnail"
#define KEY_POST_URL "url"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *blogPosts;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self addTableViewStatusBarBuffer];
    
    NSDictionary *dataDictionary = [self downloadBlogPostRawData:@BLOG_POST_RAW_DATA];
    [self initBlogPosts:dataDictionary[@KEY_POSTS]];
}

- (void) addTableViewStatusBarBuffer {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.tableView.tableHeaderView = headerView;
}

- (void) initBlogPosts: (NSDictionary *) rawData {
    self.blogPosts = [NSMutableArray array];
    for (NSDictionary *eachBlogPostDictionary in rawData) {
        BlogPost *eachBlogPost = [BlogPost blogPostWithTitle:eachBlogPostDictionary[@KEY_POST_TITLE]
                                                      Author:eachBlogPostDictionary[@KEY_POST_AUTHOR]];
        
        if (!eachBlogPostDictionary[@KEY_POST_THUMBNAIL]) {
            eachBlogPost.thumbnail = [UIImage imageNamed:@DFLT_THUMBNAIL_NAME];
        } else {
            NSURL *thumbnailUrl = [NSURL URLWithString:eachBlogPostDictionary[@KEY_POST_THUMBNAIL]];
            eachBlogPost.thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailUrl]];
        }
        
        eachBlogPost.date = eachBlogPostDictionary[@KEY_POST_DATE];
        eachBlogPost.url = [NSURL URLWithString:eachBlogPostDictionary[@KEY_POST_URL]];
        
        [self.blogPosts addObject:eachBlogPost];
    }
}

- (NSDictionary *) downloadBlogPostRawData: (NSString *) url {
    NSURL *blogUrl = [NSURL URLWithString:url];
    NSData *jsonData = [NSData dataWithContentsOfURL:blogUrl];
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    return dataDictionary;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogPosts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    BlogPost *blogPost = self.blogPosts[indexPath.row];
    cell.textLabel.text = blogPost.title;
    
    NSString *detailTextLabelText = nil;
    NSString *formattedDate = [blogPost formattedDate];
    if (formattedDate) {
        detailTextLabelText = [NSString stringWithFormat:@"Author: %@, Date: %@", blogPost.author, formattedDate];
    } else {
        detailTextLabelText = [NSString stringWithFormat:@"Author: %@", blogPost.author];
    }
    
    cell.detailTextLabel.text = detailTextLabelText;
    cell.imageView.image = blogPost.thumbnail;
    
    return cell;
}

/* 
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogPost *blogPost = self.blogPosts[indexPath.row];
    [self openBlogPostInSafari:blogPost];
}
*/

- (void) openBlogPostInSafari: (BlogPost *) blogPost {
    UIApplication *application = [UIApplication sharedApplication];
    [application openURL:blogPost.url];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        BlogPost *blogPost = self.blogPosts[indexPath.row];
        
        WebViewController *destinationController = (WebViewController *) segue.destinationViewController;
        destinationController.blogPostURL = blogPost.url;

        /* OR this:
        [segue.destinationViewController setBlogPostURL:blogPost.url];
         */
    }
}

@end
