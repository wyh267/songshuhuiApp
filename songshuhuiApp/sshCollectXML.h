//
//  sshCollectXML.h
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


//回调接口说明
@protocol sshCollectXMLDelegate
@optional

//返回数据
-(void)sshCollectXMLInfoSuccess:(NSMutableArray *)xml_info;

//返回错误码和错误字符串
-(void)sshCollectXMLnfoError:(NSString *)error;

@end




@interface sshCollectXML : NSObject<NSXMLParserDelegate>
{
    NSString *_url;
    NSMutableArray      *items;
    NSMutableDictionary *item;
    NSArray *elementToParse;
    NSMutableString *outstring;
    BOOL    storingFlag;
    
    
    id<sshCollectXMLDelegate>  delegate;
    
}

@property(assign)id<sshCollectXMLDelegate>   delegate;

@property(strong) NSMutableArray      *items; //package containing the complete response
@property(strong) NSMutableDictionary *item; //current section being parsed
@property(strong) NSMutableString *outstring;
@property(strong) NSArray *elementToParse;

-(id)initWithUrl:(NSString *)xml_url;
-(void)downloadXMLContents;
-(void)parseXMLString:(NSString *)string;

@end
