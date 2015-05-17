//
//  SplashViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "SplashViewController.h"
#import "LLALandingViewController.h"
#import "LLALoginView.h"
#import <UIView+Toast.h>
#import <Parse/Parse.h>

const CGFloat SECONDARY_VIEW_HEIGHT = 200;
const NSInteger ANIMATION_DURATION = 1.0;

@interface SplashViewController ()
@property (weak, nonatomic) IBOutlet UIView *transparency;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet UIView *primaryActionButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *primaryLogInButton;
@property (weak, nonatomic) IBOutlet UIButton *primarySignUpButton;
@property (weak, nonatomic) IBOutlet UILabel *limitlessTitle;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@property(nonatomic) LLALoginView *loginView;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeSupplementaryViews];
}

- (void)viewDidAppear:(BOOL)animated {
    [self animateTitleContainer];
    
    PFUser *currentUser = [PFUser currentUser];
    if([currentUser isAuthenticated]) {
        LLALandingViewController *lvc = [LLALandingViewController new];
        [self presentViewController:lvc animated:YES completion:nil];
    } else {
        [self animateButtonContainer];
    }
}

- (void)initializeSupplementaryViews {
    [self.transparency setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.60f]];
    
    [self setLoginView:[[LLALoginView alloc] initWithFrame:CGRectMake(0, self.primaryActionButtonContainer.frame.origin.y, self.primaryActionButtonContainer.frame.size.width, SECONDARY_VIEW_HEIGHT)]];
    [self.loginView setHidden:YES];
    [self.loginView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.loginView];
    
    NSDictionary *viewsDictionary = @{ @"loginView": self.loginView };
     NSDictionary *metrics = @{ @"viewHeight": @(SECONDARY_VIEW_HEIGHT) };
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[loginView]|"
//                                                                      options:0
//                                                                      metrics:metrics
//                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginView]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.loginView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void) animateTitleContainer
{
    [UIView animateWithDuration:ANIMATION_DURATION
                          delay: 0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.limitlessTitle.alpha = 1;
                         self.subtitle.alpha = 1;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void) animateButtonContainer
{
    [UIView animateWithDuration:ANIMATION_DURATION
                          delay: 0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.primaryLogInButton.alpha = 1.0f;
                         self.primarySignUpButton.alpha = 1.0f;
                     } completion:^(BOOL finished) {
                         
                     }];
}
- (IBAction)logInButtonTapped:(id)sender {
    [self.primaryActionButtonContainer setHidden:YES];
    //[self.loginView setHidden:NO];
    
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:@"tgb" password:@"test1234"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            LLALandingViewController *lvc = [LLALandingViewController new];
                                            [weakSelf presentViewController:lvc animated:YES completion:nil];
                                        } else {
                                            [self.view makeToast:error.description
                                                        duration:5.0
                                                        position:CSToastPositionBottom];
                                        }
                                    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginActionRequestedFromView:(LLALoginView *)view asUser:(NSString *)user withPassword:(NSString *)password {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:user password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            LLALandingViewController *lvc = [LLALandingViewController new];
                                            [weakSelf presentViewController:lvc animated:YES completion:nil];
                                        } else {
                                            [self.view makeToast:error.description
                                                        duration:2.0
                                                        position:CSToastPositionBottom];
                                        }
                                    }];
}

@end
