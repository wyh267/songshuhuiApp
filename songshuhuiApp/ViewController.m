//
//  ViewController.m
//  songshuhuiApp
//
//  Created by wu yinghao on 13-10-18.
//  Copyright (c) 2013年 wu yinghao. All rights reserved.
//

#import "ViewController.h"

#import "detailViewController.h"



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
    
    my_data=[[NSMutableArray alloc]init];
    
    self.title=@"HOME";
    
    //初始化数据
    NSArray * TitielArray = [NSArray arrayWithObjects:@"最新", @"原创", @"活动", @"译文", @"专题", nil];
    
    
    
    /*
     第一个参数是存放你需要显示的title
     第二个是设置你需要的size
     */
    _head = [[YGPSegmentedController alloc]initContentTitle:TitielArray
                                                     CGRect:CGRectMake(0, 0, 320, 44)];
    
    [_head initselectedSegmentIndex];
    [_head setDelegate:self];
    
    
    _content_table=[[UITableView alloc]initWithFrame:CGRectMake(0, 44, 320, 480) style:UITableViewStyleGrouped];
    
    _content_table.delegate=self;
    [_content_table setDataSource:self];
    
    
    [self.view addSubview:_content_table];
    [self.view addSubview:_head];
    
    
    sshCollectXML *xml=[[sshCollectXML alloc]initWithUrl:@"http://songshuhui.net/feed/"];
    [xml setDelegate:self];
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
    cell.textLabel.text=[[my_data objectAtIndex:row] objectForKey:@"title"];
    
    return cell;
    

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hi");
    NSUInteger row = [indexPath row];
    detailViewController *show=[[detailViewController alloc]init];
    [show setLink:[[my_data objectAtIndex:row] objectForKey:@"link"]];
    [self presentViewController:show animated:YES completion:Nil];
    
}






-(void)segmentedViewController:(YGPSegmentedController *)segmentedControl touchedAtIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            sshCollectXML *xml=[[sshCollectXML alloc]initWithUrl:@"http://songshuhui.net/feed/"];
            [xml setDelegate:self];
            [xml downloadXMLContents];
            break;
        }
        case 1:
        {
            NSLog(@"change to 1");
            sshCollectPages *page1=[[sshCollectPages alloc]initWithUrl:@"http://songshuhui.net/archives/tag/%E5%8E%9F%E5%88%9B?pagetag=yuanchuang"];
            [page1 setDelegate:self];
            [page1 downloadXMLContents];
            break;
        }
            
        case 2:
        {
            NSLog(@"change to 1");
            sshCollectPages *page1=[[sshCollectPages alloc]initWithUrl:@"http://songshuhui.net/archives/tag/%E6%B4%BB%E5%8A%A8?pagetag=huodong"];
            [page1 setDelegate:self];
            [page1 downloadXMLContents];
            break;
        }
            
        case 3:
        {
            NSLog(@"change to 1");
            sshCollectPages *page1=[[sshCollectPages alloc]initWithUrl:@"http://songshuhui.net/archives/tag/%E8%AF%91%E6%96%87?pagetag=yiwen"];
            [page1 setDelegate:self];
            [page1 downloadXMLContents];
            break;
        }
        
            
        case 4:
        {
            NSLog(@"change to 1");
            sshCollectPages *page1=[[sshCollectPages alloc]initWithUrl:@"http://songshuhui.net/archives/tag/%E4%B8%93%E9%A2%98?pagetag=zhuanti"];
            [page1 setDelegate:self];
            [page1 downloadXMLContents];
            break;
        }
            
        default:
            break;
    }
}



//返回数据
-(void)sshCollectXMLInfoSuccess:(NSMutableArray *)xml_info
{
    //NSLog(@"%@",xml_info);
    for (NSMutableDictionary *i in xml_info) {
        NSLog(@"title:%@",[i objectForKey:@"title"]);
        NSLog(@"link:%@",[i objectForKey:@"link"]);
    }
    my_data=xml_info;
    [_content_table reloadData];
}

-(void)sshCollectPagesInfoSuccess:(NSMutableArray *)xml_info
{
    for (NSMutableDictionary *i in xml_info) {
        NSLog(@"title:%@",[i objectForKey:@"title"]);
        NSLog(@"link:%@",[i objectForKey:@"link"]);
        
    }
    my_data=xml_info;
    [_content_table reloadData];
}


@end
