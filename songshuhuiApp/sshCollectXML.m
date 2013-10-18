//
//  sshCollectXML.m
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import "sshCollectXML.h"
#import "AFNetworking.h"


@interface sshCollectXML ()
{
    NSString *_url;
}


@end



@implementation sshCollectXML




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
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFXMLRequestOperation *operation =
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                            //self.xmlWeather = [NSMutableDictionary dictionary];
                                                            XMLParser.delegate = self;
                                                            [XMLParser setShouldProcessNamespaces:YES];
                                                            [XMLParser parse];
                                                        }
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK"
                                                                                               otherButtonTitles:nil];
                                                            [av show];
                                                        }];
    
    
    [operation start];
    NSLog(@"Download contents now,please wait....");
    
    
    
}




@end
