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
    NSMutableDictionary *xmlWeather; //package containing the complete response
    NSMutableDictionary *currentDictionary; //current section being parsed
    NSString *previousElementName;
    NSString *elementName;
    NSMutableString *outstring;
    
}

@property(strong) NSMutableDictionary *xmlWeather; //package containing the complete response
@property(strong) NSMutableDictionary *currentDictionary; //current section being parsed
@property(strong) NSString *previousElementName;
@property(strong) NSString *elementName;
@property(strong) NSMutableString *outstring;

-(id)initWithUrl:(NSString *)xml_url;
-(void)downloadXMLContents;

@end
