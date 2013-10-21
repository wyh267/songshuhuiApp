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
    /*
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Success: %@", operation.responseString);
        NSData *data=[NSData dataWithBytes:[operation.responseString UTF8String] length:[operation.responseString length]];
        NSXMLParser *XMLParser = [[NSXMLParser alloc] initWithData:data];
        XMLParser.delegate = self;
        [XMLParser setShouldProcessNamespaces:YES];
        [XMLParser parse];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    [operation start];
    
    */
    
    AFXMLRequestOperation *operation =
    
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                            self.xmlWeather = [NSMutableDictionary dictionary];
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
                                                            NSLog(@"%@",error);
                                                        }];
    

    [operation start];
     
    
    
    NSLog(@"Download contents now,please wait....");
    
    
    
}







- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    
    NSLog(@"NodeName:%@",elementName);
}




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    NSLog(@"Value:%@",string);
   
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"EndNodeName:%@",elementName);
    
}



-(void) parserDidEndDocument:(NSXMLParser *)parser
{
    
}




@end
