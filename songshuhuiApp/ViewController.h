//
//  ViewController.h
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGPSegmentedController.h"
#import "sshCollectXML.h"

@interface ViewController : UIViewController<YGPSegmentedControllerDelegate,UITableViewDataSource,UITableViewDelegate,sshCollectXMLDelegate>

@end
