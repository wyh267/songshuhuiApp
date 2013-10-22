//
//  sshCollectPages.m
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-22.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import "sshCollectPages.h"
#import "AFNetworking.h"
#import "RegexKitLite.h"

@implementation sshCollectPages




-(id)initWithUrl:(NSString *)xml_url
{
    self=[super init];
    if (self) {
        _url=xml_url;
    }
    
    return self;
}


-(void)downloadXMLContents
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Success: %@", operation.responseString);
        //[self parseXMLString:operation.responseString];
        [self parsePages:operation.responseString];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    [operation start];
    
    
    
    NSLog(@"Download contents now,please wait....");
}



-(void)parsePages:(NSString *)string
{
    //NSString *searchString = @"$10.23, $10.2, $3099" ;
    NSString *regexTitleString  = @"<h3 class=\"storytitle\">.*?>(.*?)</a>";
    NSArray  *matchTitleArray   = NULL;
    matchTitleArray = [string arrayOfCaptureComponentsMatchedByRegex:regexTitleString];
    
    NSString *regexLinkString  = @"<h3 class=\"storytitle\">.*?href=\"(.*?)\"";
    NSArray  *matchLinkArray   = NULL;
    matchLinkArray = [string arrayOfCaptureComponentsMatchedByRegex:regexLinkString];
    
    

    NSMutableArray *resArray=[[NSMutableArray alloc]init];
    for (int i=0; i<[matchTitleArray count]; i++) {
        NSDictionary *m=[[NSDictionary alloc]initWithObjectsAndKeys:
                         [[matchTitleArray objectAtIndex:i] objectAtIndex:1],@"title",
                         [[matchLinkArray objectAtIndex:i] objectAtIndex:1],@"link",
                         nil];
        [resArray addObject:m];
    }
    
    
    [self.delegate  sshCollectPagesInfoSuccess:resArray];
}



@end
