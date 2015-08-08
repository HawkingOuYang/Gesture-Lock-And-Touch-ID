//
//  ViewController.m
//  GestureSDK_Demo
//
//  Created by OYXJ on 15/8/8.
//  Copyright (c) 2015年 OYXJ. All rights reserved.
//

#import "ViewController.h"

#import "GestureSetupViewController.h"


@interface ViewController ()

@end


@implementation ViewController

#pragma mark - life cycle

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightItemAction:)];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightItem release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 按钮事件

- (void)rightItemAction:(UIBarButtonItem *)sender
{
    GestureSetupViewController * gVC = [[GestureSetupViewController alloc] init];
    
    [self.navigationController pushViewController: gVC animated:YES];
    [gVC release];
}

@end
