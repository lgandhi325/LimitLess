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
#import "LLALandingIconView.h"
#import "LLAUser.h"
#import "LLAUserSearchViewController.h"
#import <Parse/Parse.h>

@interface LLALandingViewController ()

@property (nonatomic) LLALandingIconView *dailyFeedView;
@property (nonatomic) LLALandingIconView *postView;
@property (nonatomic) LLALandingIconView *profileView;
@property (nonatomic) LLALandingIconView *socialView;

@end

@implementation LLALandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    [self.navigationController setNavigationBarHidden:YES];
    
    [self setDailyFeedView:[[LLALandingIconView alloc] initWithTitle:@"Daily Feed" andImage:[UIImage imageNamed:@"FullSizedRender"]]];
    [self.dailyFeedView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dailyFeedView addTarget:self action:@selector(dailyFeedTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailyFeedView];
    
    [self setPostView:[[LLALandingIconView alloc] initWithTitle:@"Post" andImage:[UIImage imageNamed:@"FullSizedRender"]]];
    [self.postView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.postView addTarget:self action:@selector(postTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postView];
    
    [self setProfileView:[[LLALandingIconView alloc] initWithTitle:@"Profile" andImage:[UIImage imageNamed:@"FullSizedRender"]]];
    [self.profileView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.profileView addTarget:self action:@selector(profileTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.profileView];
    
    [self setSocialView:[[LLALandingIconView alloc] initWithTitle:@"Social" andImage:[UIImage imageNamed:@"FullSizedRender"]]];
    [self.socialView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.socialView addTarget:self action:@selector(socialTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.socialView];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *views = @{ @"dailyFeed": self.dailyFeedView,
                             @"social": self.socialView,
                             @"post": self.postView,
                             @"profile": self.profileView
                             };
    
    CGFloat sidewidth = (self.view.bounds.size.width - 150 - 150 - 10) / 9;
    
    NSDictionary *metrics = @{ @"marginLength": @(sidewidth),
                               @"viewSize": @(150) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(marginLength)-[dailyFeed(viewSize)]-10-[post(viewSize)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(marginLength)-[profile(viewSize)]-10-[social(viewSize)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[dailyFeed(viewSize)]-10-[profile(viewSize)]-(marginLength)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[post(viewSize)]-10-[social(viewSize)]-(marginLength)-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
}

- (void) dailyFeedTapped:(id) sender {
    LLAFeedContainerViewController *dfvc = [LLAFeedContainerViewController new];
    [self.navigationController pushViewController:dfvc animated:YES];
}

- (void) postTapped:(id) sender {
    LLAPostViewController *dfvc = [LLAPostViewController new];
    
    self.providesPresentationContextTransitionStyle = YES;
    self.definesPresentationContext = YES;
    [self setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    
    [self.navigationController pushViewController:dfvc animated:YES];
}

- (void) socialTapped:(id)sender {
    LLAUserSearchViewController *searchVC = [LLAUserSearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void) profileTapped:(id) sender {
    LLAProfileViewController *profileVC = [LLAProfileViewController new];
    [profileVC setUser:[LLAUser currentUser]];
    [self.navigationController pushViewController:profileVC animated:YES];
}

@end
