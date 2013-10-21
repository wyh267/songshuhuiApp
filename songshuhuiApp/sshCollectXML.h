//
//  sshCollectXML.h
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sshCollectXML : NSObject<NSXMLParserDelegate>
{
    NSString *_url;
    NSMutableArray      *items;
    NSMutableDictionary *item;
    NSArray *elementToParse;
    NSMutableString *outstring;
    BOOL    storingFlag;
    
}

@property(strong) NSMutableArray      *items; //package containing the complete response
@property(strong) NSMutableDictionary *item; //current section being parsed
@property(strong) NSMutableString *outstring;
@property(strong) NSArray *elementToParse;

-(id)initWithUrl:(NSString *)xml_url;
-(void)downloadXMLContents;
-(void)parseXMLString:(NSString *)string;

@end
