//
//  detailViewController.m
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-22.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)setLink:(NSString *)link
{
    _link=link;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    detailWebView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    detailWebView.scalesPageToFit = YES;
    [detailWebView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_link]]];
    
    [self.view addSubview:detailWebView];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
