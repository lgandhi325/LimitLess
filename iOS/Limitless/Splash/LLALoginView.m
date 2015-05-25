//
//  LLALoginViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/10/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALoginView.h"
#import "UIColor+LimitlessColors.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface LLALoginView ()
@property (nonatomic) UIButton *backButton;
@property (nonatomic) UITextField *usernameField;
@property (nonatomic) UITextField *passwordField;
@property (nonatomic) UIButton *loginButton;
@end

@implementation LLALoginView

- (id)init {
    self = [super init];
    if(self) {
        [self configure];
    }
    return self;
}

- (void) configure {
    [self setBackButton:[UIButton new]];
    [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.backButton setTitle:NSLocalizedString(@"< back", nil) forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    [self setUsernameField:[self initializeNewUITextField]];
    [self addSubview:self.usernameField];
    
    [self setPasswordField:[self initializeNewUITextField]];
    [self addSubview:self.passwordField];
    
    [self setLoginButton:[UIButton new]];
    [self.loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.loginButton setTitleColor:[UIColor limitlessBlueColor] forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setTitle:NSLocalizedString(@"Log in", nil) forState:UIControlStateNormal];
    [self addSubview:self.loginButton];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *views = @{ @"backButton": self.backButton,
                             @"usernameField": self.usernameField,
                             @"passwordField": self.passwordField,
                             @"loginButton": self.loginButton };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[backButton]-8-[usernameField(30)]-10-[passwordField(30)]-8-[loginButton]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backButton]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[usernameField]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[passwordField]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[loginButton]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

- (void) backButtonTapped:(id)sender {
    [self.delegate backActionRequestedFromLoginView:self];
}

- (void) loginButtonTapped:(id)sender {
    NSString *username = [self.usernameField text];
    NSString *password = [self.passwordField text];
    
    //TODO: Validation logic
    
    [self.delegate loginActionRequestedFromLoginView:self asUser:username withPassword:password];
}
     
- (UITextField *) initializeNewUITextField {
    UITextField *temp = [UITextField new];
    [temp setTranslatesAutoresizingMaskIntoConstraints:NO];
    [temp setBackgroundColor:[UIColor blackColor]];
    [temp setTextColor:[UIColor whiteColor]];
    [temp setTextAlignment:NSTextAlignmentCenter];
    return temp;
}

@end
