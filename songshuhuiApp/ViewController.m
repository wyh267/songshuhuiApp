//
//  ViewController.m
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import "ViewController.h"
#import "sshCollectXML.h"



@interface ViewController ()
{
    YGPSegmentedController *_head;
    UITableView            *_content_table;
    NSMutableArray                *my_data;
}


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    my_data=[[NSMutableArray alloc]initWithObjects:@"a",@"b",@"c",nil];
    
    self.title=@"HOME";
    
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithObjects:@"网易", @"新浪", @"腾讯", @"搜狐", @"百度", @"谷歌", @"奇虎",@"阿里",@"火狐",@"天猫", nil];
    
    
    
    /*
     第一个参数是存放你需要显示的title
     第二个是设置你需要的size
     */
    _head = [[YGPSegmentedController alloc]initContentTitle:TitielArray
                                                     CGRect:CGRectMake(0, 0, 320, 44)];
    
    [_head setDelegate:self];
    
    
    _content_table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480) style:UITableViewStyleGrouped];
    
    _content_table.delegate=self;
    [_content_table setDataSource:self];
   // _content_table.dataSource=self;
    //[_content_table reloadData];
    
    
    [self.view addSubview:_content_table];
    [self.view addSubview:_head];
    
    
    sshCollectXML *xml=[[sshCollectXML alloc]initWithUrl:@"http://songshuhui.net/feed/"];
    [xml downloadXMLContents];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [my_data count];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell=[[ UITableViewCell alloc ]initWithStyle:UITableViewStyleGrouped reuseIdentifier:CustomCellIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text=[my_data objectAtIndex:row];
    
    return cell;
    

    
}



@end
