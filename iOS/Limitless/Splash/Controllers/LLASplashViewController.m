//
//  LLASplashViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 6/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLASplashViewController.h"
#import "LLAtitleView.h"
#import "LLASplashButtonContainerView.h"
#import "LLASplashLoginView.h"
#import "LLASplashSignUpView.h"

typedef NS_ENUM(NSInteger, LLASplashViewType) {
    LLASplashViewTypeDefault = 0,
    LLASplashViewTypeLogin,
    LLASplashViewTypeSignup
};

@interface LLASplashViewController ()

@property (nonatomic) UIScrollView *primaryScrollView;
@property (nonatomic) UIImageView *backdropImageView;
@property (nonatomic) UIView *backdrop;
@property (nonatomic) LLATitleView *titleView;
@property (nonatomic) LLASplashButtonContainerView *buttonView;
@property (nonatomic) LLASplashLoginView *loginView;
@property (nonatomic) LLASplashSignUpView *signUpView;

@property (nonatomic) LLASplashViewType currentViewType;

@end

@implementation LLASplashViewController

-(instancetype)init {
    self = [super init];
    if(self) {
        _currentViewType = LLASplashViewTypeDefault;
        [self initViews];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.primaryScrollView setContentSize:self.view.frame.size];
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    NSDictionary *views = @{ @"scrollView": self.primaryScrollView,
                             @"backdropImage": self.backdropImageView,
                             @"backdrop": self.backdrop,
                             @"titleView": self.titleView,
                             @"buttonView": self.buttonView,
                             @"loginView": self.loginView,
                             @"signupView": self.signUpView };
    
    NSDictionary *metrics = @{ @"width": @(self.view.frame.size.width) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backdropImage]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backdropImage]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backdrop]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backdrop]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView(width)]|"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:views]];
    
    [self.primaryScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[titleView]-300-[buttonView]"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:views]];
    
    [self.primaryScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[titleView]-300-[loginView]"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:views]];
    
    [self.primaryScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[titleView]-300-[signupView]"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:views]];
    
    [self.primaryScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginView(width)]|"
                                                                                   options:0
                                                                                   metrics:metrics
                                                                                     views:views]];
    
    [self.primaryScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[signupView(width)]"
                                                                                   options:0
                                                                                   metrics:metrics
                                                                                     views:views]];
    
    [self.primaryScrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.primaryScrollView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.titleView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.f
                                                                        constant:0.f]];
    
    [self.primaryScrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.primaryScrollView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.buttonView
                                                                       attribute:NSLayoutAttributeCenterX
                                                                      multiplier:1.f
                                                                        constant:0.f]];
    
    [self.primaryScrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.buttonView
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.primaryScrollView
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.f
                                                                        constant:0.f]];
}

-(void)initViews {
    [self setBackdropImageView:[UIImageView new]];
    [self.backdropImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.backdropImageView setImage:[UIImage imageNamed:@"SplashBackground"]];
    [self.view addSubview:self.backdropImageView];
    
    [self setBackdrop:[UIView new]];
    [self.backdrop setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.backdrop setBackgroundColor:[UIColor blackColor]];
    [self.backdrop setAlpha:0.65f];
    [self.view addSubview:self.backdrop];
    
    [self setPrimaryScrollView:[UIScrollView new]];
    [self.primaryScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.primaryScrollView];
    
    [self setTitleView:[[LLATitleView alloc] initWithSubtitle:@"Believe. Achieve. Inspire."]];
    [self.titleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.primaryScrollView addSubview:self.titleView];
    
    [self setButtonView:[LLASplashButtonContainerView new]];
    [self.buttonView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.buttonView setDelegate:self];
    [self.primaryScrollView addSubview:self.buttonView];
    
    [self setLoginView:[LLASplashLoginView new]];
    [self.loginView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginView setDelegate:self];
    [self.loginView setHidden:YES];
    [self.primaryScrollView addSubview:self.loginView];
    
    [self setSignUpView:[LLASplashSignUpView new]];
    [self.signUpView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.signUpView setDelegate:self];
    [self.signUpView setHidden:YES];
    [self.primaryScrollView addSubview:self.signUpView];
}

-(void)switchToViewType:(LLASplashViewType)viewType {
    if(viewType == self.currentViewType) return;
    
    [[self viewForState:self.currentViewType] setHidden:YES];
    [[self viewForState:self.currentViewType] setUserInteractionEnabled:NO];
    [self setCurrentViewType:viewType];
    [[self viewForState:self.currentViewType] setHidden:NO];
    [[self viewForState:self.currentViewType] setUserInteractionEnabled:YES];
}

-(UIView *)viewForState:(LLASplashViewType)viewType {
    switch (viewType) {
        case LLASplashViewTypeDefault:
            return self.buttonView;
        case LLASplashViewTypeLogin:
            return self.loginView;
        case LLASplashViewTypeSignup:
            return self.signUpView;
        default:
            return nil;
    }
}

-(void)backActionRequestedFromLoginView:(LLASplashLoginView *)view {
    [self switchToViewType:LLASplashViewTypeDefault];
}

-(void)didTapLogInButtonFromButtonView:(LLASplashButtonContainerView *)buttonView {
    [self switchToViewType:LLASplashViewTypeLogin];
}

-(void)backActionRequestedFromSignUpView:(LLASplashSignUpView *)view {
    [self switchToViewType:LLASplashViewTypeDefault];
}

-(void)didTapSignUpButtonFromButtonView:(LLASplashButtonContainerView *)buttonView {
    [self switchToViewType:LLASplashViewTypeSignup];
}

-(void)loginActionRequestedFromLoginView:(LLASplashLoginView *)view asUser:(NSString *)user withPassword:(NSString *)password {
    NSLog(@"Login");
}

-(void)signUpActionRequestedFromSignUpView:(LLASplashSignUpView *)view withEmail:(NSString *)email firstname:(NSString *)firstname lastname:(NSString *)lastname asUser:(NSString *)user withPassword:(NSString *)password {
     NSLog(@"Register");
}

@end
