//
//  XYMainViewController.m
//  Xyrality
//
//  Created by Sergio on 10/2/15.
//  Copyright (c) 2015 BrightGrove. All rights reserved.
//

#import "XYMainViewController.h"
#import "XYWorldDataSource.h"

@interface XYMainViewController ()

//XYB
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation XYMainViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView reloadData];
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
