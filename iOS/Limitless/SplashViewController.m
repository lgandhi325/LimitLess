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
#import "LLAUser.h"
#import <UIView+Toast.h>
#import <Parse/Parse.h>

const CGFloat SECONDARY_VIEW_HEIGHT = 200;
const NSInteger ANIMATION_DURATION = 1.0;

typedef NS_ENUM (NSInteger, LLASplashScreenState) {
    LLASplashScreenStateDefault,
    LLASplashScreenStateLogin,
    LLASplashScreenStateSignUp,
    LLASplashScreenStateLoading
};

@interface SplashViewController ()
@property (weak, nonatomic) IBOutlet UIView *transparency;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet UIView *primaryActionButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *primaryLogInButton;
@property (weak, nonatomic) IBOutlet UIButton *primarySignUpButton;
@property (weak, nonatomic) IBOutlet UILabel *limitlessTitle;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;

@property (nonatomic) LLALoginView *loginView;
@property (nonatomic) LLASplashScreenState viewState;
@property (nonatomic) BOOL keyboardOpen;

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setViewState:LLASplashScreenStateDefault];
    
    [self initializeSupplementaryViews];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [self animateTitleContainer];
    
    LLAUser *currentUser = [LLAUser currentUser];
    if([currentUser isAuthenticated]) {
        LLALandingViewController *lvc = [LLALandingViewController new];
        [self presentViewController:lvc animated:YES completion:nil];
    } else {
        [self animateButtonContainer];
    }
}

- (void)initializeSupplementaryViews {
    [self.transparency setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.60f]];
    
    [self setLoginView:[LLALoginView new]];
    [self.loginView setHidden:YES];
    [self.loginView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginView setDelegate:self];
    [self.view addSubview:self.loginView];
    
    NSDictionary *viewsDictionary = @{ @"loginView": self.loginView };
     NSDictionary *metrics = @{ @"viewHeight": @(SECONDARY_VIEW_HEIGHT) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loginView(viewHeight)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
    
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
    [self setViewState:LLASplashScreenStateLogin];
    [self.primaryActionButtonContainer setHidden:YES];
    [self.loginView setHidden:NO];
    
}

- (void) attempLogin {
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

- (void)loginActionRequestedFromLoginView:(LLALoginView *)view asUser:(NSString *)user withPassword:(NSString *)password {
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

- (void)backActionRequestedFromLoginView:(LLALoginView *)view {
    [self.primaryActionButtonContainer setHidden:NO];
    [self.loginView setHidden:YES];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if(self.keyboardOpen) return;
    self.keyboardOpen = YES;
    
    NSDictionary* info = [notification userInfo];
    CGRect keyPadFrame=[[UIApplication sharedApplication].keyWindow convertRect:[[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue] fromView:self.view];
    CGSize kbSize =keyPadFrame.size;
    CGRect aRect = self.view.bounds;
    aRect.size.height -= (kbSize.height);
    
    [self slideViewToYPosition:(kbSize.height)];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    self.keyboardOpen = NO;
    [self slideViewToYPosition:0];
}

- (void) slideViewToYPosition:(CGFloat)yPos {
    UIView *slidingView;
    switch (self.viewState) {
        case LLASplashScreenStateLogin:
            slidingView = self.loginView;
            break;
        case LLASplashScreenStateDefault:
        case LLASplashScreenStateLoading:
        case LLASplashScreenStateSignUp:
        default:
            return;
    }
    
    CGPoint newOrigin = slidingView.frame.origin;
    
    if(self.keyboardOpen) {
        newOrigin.y = slidingView.frame.origin.y - yPos;
    } else {
        newOrigin.y = yPos;
    }
    slidingView.frame = CGRectMake(newOrigin.x, newOrigin.y, slidingView.frame.size.width, slidingView.frame.size.height);
    [slidingView setNeedsDisplay];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}
@end
