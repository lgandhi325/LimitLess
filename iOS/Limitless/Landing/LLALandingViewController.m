//
//  LLALandingViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/7/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALandingViewController.h"
#import "LLADailyFeedViewController.h"
#import "SplashViewController.h"
#import "LLAFeedContainerViewController.h"
#import "LLAProfileViewController.h"
#import "LLAPostViewController.h"
#import "LLAUser.h"
#import <Parse/Parse.h>

@interface LLALandingViewController ()
@property (weak, nonatomic) IBOutlet UIView *dailyFeedContainer;
@property (weak, nonatomic) IBOutlet UIView *socialContainer;
@property (weak, nonatomic) IBOutlet UIView *profileContainer;

@end

@implementation LLALandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setDailyFeedTapGesture];
}

- (void)setDailyFeedTapGesture {
//    UIGestureRecognizer *dfTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                           action:@selector(handleDailyFeedTap:)];
//    dfTapGR.delegate = self;
//    [self.dailyFeedContainer addGestureRecognizer:dfTapGR];
//    [self.socialContainer addGestureRecognizer:dfTapGR];
//    [self.profileContainer addGestureRecognizer:dfTapGR];
}

- (void)setSocialTapGesture {
    UIGestureRecognizer *sTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(handleSocialTap:)];
    sTapGR.delegate = self;
    [self.dailyFeedContainer addGestureRecognizer:sTapGR];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleDailyFeedTap:(UITapGestureRecognizer *)sender {
    if(sender.view == self.dailyFeedContainer) {
        LLAFeedContainerViewController *dfvc = [LLAFeedContainerViewController new];
        [self presentViewController:dfvc animated:YES completion:nil];
    }
    
    if(sender.view == self.socialContainer) {
        LLAPostViewController *dfvc = [LLAPostViewController new];
        self.definesPresentationContext = YES; //self is presenting view controller
        dfvc.view.backgroundColor = [UIColor clearColor];
        dfvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:dfvc animated:YES completion:nil];
    }
    
    if(sender.view == self.profileContainer) {
        LLAProfileViewController *profileVC = [LLAProfileViewController new];
        [profileVC setUser:[LLAUser currentUser]];
        [self presentViewController:profileVC animated:YES completion:nil];
    }
}

- (void)handleSocialTap:(UITapGestureRecognizer *)sender {
    [LLAUser logOut];
    SplashViewController *svc = [SplashViewController new];
    [self presentViewController:svc animated:YES completion:nil];
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
