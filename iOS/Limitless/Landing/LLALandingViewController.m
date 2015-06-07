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

@property (nonatomic) UIView *backdrop;
@property (nonatomic) LLAPostViewController *postViewController;

@property (nonatomic) LLALandingIconView *dailyFeedView;
@property (nonatomic) LLALandingIconView *postView;
@property (nonatomic) LLALandingIconView *profileView;
@property (nonatomic) LLALandingIconView *socialView;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end

@implementation LLALandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void) configure {
    [self setDailyFeedView:[[LLALandingIconView alloc] initWithTitle:@"Daily Feed!" andImage:[UIImage imageNamed:@"Globe"]]];
    [self.dailyFeedView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.dailyFeedView addTarget:self action:@selector(dailyFeedTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dailyFeedView];
    
    [self setPostView:[[LLALandingIconView alloc] initWithTitle:@"Post" andImage:[UIImage imageNamed:@"Keyboard"]]];
    [self.postView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.postView addTarget:self action:@selector(postTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.postView];
    
    [self setProfileView:[[LLALandingIconView alloc] initWithTitle:@"Profile" andImageURL:[NSURL URLWithString:[(PFFile*)[[PFUser currentUser] objectForKey:@"profileImage"] url]]]];
    [self.profileView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.profileView addTarget:self action:@selector(profileTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.profileView];
    
    [self setSocialView:[[LLALandingIconView alloc] initWithTitle:@"Social" andImage:[UIImage imageNamed:@"Facebook"]]];
    [self.socialView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.socialView addTarget:self action:@selector(socialTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.socialView];
    
    [self setBackdrop:[[UIView alloc] initWithFrame:self.view.frame]];
    [self.backdrop setBackgroundColor:[UIColor blackColor]];
    [self.backdrop setAlpha:0.f];
    [self.view addSubview:self.backdrop];
    
    [self setPostViewController:[LLAPostViewController new]];
    [self addChildViewController:self.postViewController];
    self.postViewController.view.frame = self.view.frame;
    self.postViewController.view.alpha = 0.f;
    [self.view addSubview:self.postViewController.view];
    [self.postViewController didMoveToParentViewController:self];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapPostViewController:)];
    [self.postViewController.view addGestureRecognizer:tapGR];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *views = @{ @"dailyFeed": self.dailyFeedView,
                             @"social": self.socialView,
                             @"post": self.postView,
                             @"profile": self.profileView
                             };
    
    CGFloat topMargin = self.subtitleLabel.frame.origin.y + 100;
    
    NSDictionary *metrics = @{ @"viewSize": @(150),
                               @"topMargin": @(topMargin)};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[dailyFeed]-10-[post]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[profile]-10-[social]-|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topMargin)-[dailyFeed]-10-[profile]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(topMargin)-[post]-10-[social]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dailyFeedView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.postView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.socialView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.dailyFeedView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.dailyFeedView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.postView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.postView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.profileView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.profileView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.socialView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.socialView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void) dailyFeedTapped:(id) sender {
    LLAFeedContainerViewController *dfvc = [LLAFeedContainerViewController new];
    [self.navigationController pushViewController:dfvc animated:YES];
}

- (void) postTapped:(id) sender {
    self.backdrop.hidden = NO;
    self.postViewController.view.hidden = false;
    
    [UIView animateWithDuration:0.75f
                     animations:^{
                         self.backdrop.alpha = 0.8f;
                         self.postViewController.view.alpha = 1.f;
                     } completion:nil];
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

-(void) didTapPostViewController:(id)sender {
    [UIView animateWithDuration:0.75f
                     animations:^{
                         self.backdrop.alpha = 0.f;
                         self.postViewController.view.alpha = 0.f;
                     } completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
