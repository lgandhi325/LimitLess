//
//  SplashViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "SplashViewController.h"
#import "LLALandingNavigationViewController.h"
#import "LLASplashLoginView.h"
#import "LLASplashSignUpView.h"
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

@property (nonatomic) LLASplashLoginView *loginView;
@property (nonatomic) LLASplashSignUpView *signUpView;
@property (nonatomic) LLASplashScreenState viewState;
@property (nonatomic) BOOL keyboardOpen;
@property (nonatomic) BOOL alreadyAuthenticated;
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
        LLALandingNavigationViewController *lvc = [LLALandingNavigationViewController new];
        [self.view.window.rootViewController presentViewController:lvc animated:YES completion:nil];
    } else {
        [self animateButtonContainer];
    }
}

- (void)initializeSupplementaryViews {
    [self.transparency setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.60f]];
    
    [self setLoginView:[LLASplashLoginView new]];
    [self.loginView setAlpha:0.f];
    [self.loginView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginView setDelegate:self];
    [self.view addSubview:self.loginView];
    
    [self setSignUpView:[LLASplashSignUpView new]];
    [self.signUpView setAlpha:0.f];
    [self.signUpView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.signUpView setDelegate:self];
    [self.view addSubview:self.signUpView];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *viewsDictionary = @{ @"loginView": self.loginView,
                                       @"signUpView": self.signUpView
                                       };
    
    NSDictionary *metrics = @{ @"viewHeight": @(SECONDARY_VIEW_HEIGHT) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loginView(viewHeight)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginView]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[signUpView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signUpView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
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
    [self animateView:self.loginView shouldShow:YES];
}

- (IBAction)signUpButtonTapped:(id)sender {
    [self setViewState:LLASplashScreenStateSignUp];
    [self.signUpView setAlpha:1.f];
    [self.primaryActionButtonContainer setAlpha:0.f];
    
    //[self animateView:self.signUpView shouldShow:YES];
}

- (void) attempLogin {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:@"tgb" password:@"test1234"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            LLALandingNavigationViewController *lvc = [LLALandingNavigationViewController new];
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

- (void)loginActionRequestedFromLoginView:(LLASplashLoginView *)view asUser:(NSString *)user withPassword:(NSString *)password {
    [self loginAsUser:user withPassword:password];
}

- (void)loginAsUser:(NSString *)username withPassword:(NSString *) password {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:@"antlip" password:@"test1234"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            LLALandingNavigationViewController *lvc = [LLALandingNavigationViewController new];
                                            [weakSelf presentViewController:lvc animated:YES completion:nil];
                                        } else {
                                            [self.view makeToast:error.description
                                                        duration:2.0
                                                        position:CSToastPositionBottom];
                                        }
                                    }];
}

- (void)signUpActionRequestedFromSignUpView:(LLASplashSignUpView *)view withEmail:(NSString *)email firstname:(NSString *)firstname lastname:(NSString *)lastname asUser:(NSString *)user withPassword:(NSString *)password {
    
    LLAUser *newUser = [[LLAUser alloc] init];
    [newUser setEmail:email];
    [newUser setFirstname:firstname];
    [newUser setLastname:lastname];
    [newUser setUsername:user];
    [newUser setPassword:password];

    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error) {
            NSLog(@"%@", error);
        } else {
            [self loginAsUser:user withPassword:password];
        }
    }];
}

- (void)backActionRequestedFromLoginView:(LLASplashLoginView *)view {
    [self setViewState:LLASplashScreenStateDefault];
    [self animateView:view shouldShow:NO];
}

- (void) backActionRequestedFromSignUpView:(LLASplashSignUpView *)view {
    [self setViewState:LLASplashScreenStateDefault];
    [self animateView:view shouldShow:NO];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    //if(self.keyboardOpen) return;
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
    [slidingView setFrame:CGRectMake(0, newOrigin.y, slidingView.frame.size.width, slidingView.frame.size.height)];
    [slidingView setNeedsDisplay];
}

- (void)animateView:(UIView *)view shouldShow:(BOOL)show {
    [UIView animateWithDuration:ANIMATION_DURATION
                          delay: 0.f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.primaryActionButtonContainer.alpha = show ? 0 : 1;
                         view.alpha = show ? 1 : 0;
                     } completion:^(BOOL finished) {
                         
                     }];
}

-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (BOOL)shouldAutorotate {
    return NO;
}
    
@end
