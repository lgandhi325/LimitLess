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

@property(nonatomic, retain) UINavigationController *navController;

@end

@implementation LLALandingNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LLALandingViewController *one = [LLALandingViewController new];
    self.navController = [[UINavigationController alloc] initWithRootViewController:one];
    [self.view addSubview:self.navController.view];
}

@end
