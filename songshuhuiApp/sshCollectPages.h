//
//  sshCollectPages.h
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-22.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import <Foundation/Foundation.h>


//回调接口说明
@protocol sshCollectPagesDelegate
@optional

//返回数据
-(void)sshCollectPagesInfoSuccess:(NSMutableArray *)xml_info;

//返回错误码和错误字符串
-(void)sshCollectPagesinfoError:(NSString *)error;

@end



@interface sshCollectPages : NSObject
{
    NSString *_url;
    
    id<sshCollectPagesDelegate> delegate;
    
}

@property(assign)id<sshCollectPagesDelegate>   delegate;

-(id)initWithUrl:(NSString *)xml_url;
-(void)downloadXMLContents;
-(void)parsePages:(NSString *)string;

@end
