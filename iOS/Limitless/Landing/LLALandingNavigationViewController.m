//
//  LLALandingNavigationViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALandingNavigationViewController.h"
#import "LLALandingViewController.h"

@interface LLALandingNavigationViewController ()

@end

@implementation LLALandingNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LLALandingViewController *landingVC = [LLALandingViewController new];
    [self.view addSubview:landingVC.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
