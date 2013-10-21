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
    storingFlag=false;
    elementToParse = [[NSArray alloc] initWithObjects:@"title",@"creator",@"description",@"encoded", nil];
    
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Success: %@", operation.responseString);
        [self parseXMLString:operation.responseString];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    [operation start];
    */
    
    
    AFXMLRequestOperation *operation =
    
    [AFXMLRequestOperation XMLParserRequestOperationWithRequest:request
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, NSXMLParser *XMLParser) {
                                                            
                                                        }
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, NSXMLParser *XMLParser) {
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK"
                                                                                               otherButtonTitles:nil];
                                                            [av show];
                                                            //NSLog(@"%@",error);
                                                            XMLParser.delegate = self;
                                                            [XMLParser setShouldProcessNamespaces:YES];
                                                            [XMLParser parse];
                                                        }];
    

    [operation start];
     
    
    
    NSLog(@"Download contents now,please wait....");
    
    
    
}



-(void)parseXMLString:(NSString *)string
{
    NSString * regex        = @"http://songshuhui\\.net/feed";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:string];
    NSLog(@"Match:%d",isMatch);
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict  {
    
    if ([elementName isEqualToString:@"channel"]) {
        NSLog(@"NodeName:%@",elementName);
        
        items=[[NSMutableArray alloc]init];
        
    }
    
    if ([elementName isEqualToString:@"item"]) {
        NSLog(@"NodeName:%@",elementName);
        item=[[NSMutableDictionary alloc]init];
    }
    
    
    
    storingFlag = [elementToParse containsObject:elementName];
}




- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (storingFlag) {
        if (!self.outstring) {
            self.outstring = [[NSMutableString alloc] initWithString:string];
        }
        else {
            [self.outstring appendString:string];
        }
    }
    
    
   // NSLog(@"Value:%@",string);
   
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        NSLog(@"itmes end");
        [items addObject:item];
        item = nil;
    }
    
    if (storingFlag) {
        //去掉字符串的空格
        NSString *trimmedString = [self.outstring stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        //将字符串置空
        [self.outstring setString:@""];
        /*
        NSLog(@"ele:::::%@",elementName);
        if ([elementName isEqualToString:@"title"]) {
            [item setObject:trimmedString forKey:@"title"];
            //NSLog(@"title:%@",[item objectForKey:@"title"]);

        }
        if ([elementName isEqualToString:@"creator"]) {
            [item setObject:trimmedString forKey:@"creator"];
             //NSLog(@"dc:creator:%@",[item objectForKey:@"dc:creator"]);
        }
        if ([elementName isEqualToString:@"description"]) {
            [item setObject:trimmedString forKey:@"description"];
             //NSLog(@"description:%@",[item objectForKey:@"description"]);
        }
        
        if ([elementName isEqualToString:@"encoded"]) {
            [item setObject:trimmedString forKey:@"encoded"];
            //NSLog(@"description:%@",[item objectForKey:@"description"]);
        }
         */
        
        [item setObject:trimmedString forKey:elementName];
        
    }
    
}



-(void) parserDidEndDocument:(NSXMLParser *)parser
{
    //NSLog(@"%@",items);
    for (NSMutableDictionary *i in items) {
        NSLog(@"title:%@",[i objectForKey:@"title"]);
        NSLog(@"creator:%@",[i objectForKey:@"creator"]);
        NSLog(@"description:%@",[i objectForKey:@"description"]);
        NSLog(@"encoded:%@",[i objectForKey:@"encoded"]);
    }
}




@end
