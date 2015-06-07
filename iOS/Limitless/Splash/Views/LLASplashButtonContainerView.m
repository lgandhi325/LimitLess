//
//  LLASplashButtonView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 6/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLASplashButtonContainerView.h"

@interface LLASplashButtonContainerView()

@property (nonatomic) UIButton *logInButton;
@property (nonatomic) UIButton *signUpButton;

@end

@implementation LLASplashButtonContainerView

- (id)init {
    self = [super init];
    if(self) {
        [self initializeProperties];
    }
    return self;
}

-(void)initializeProperties {
    [self setLogInButton:[UIButton new]];
    [self.logInButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.logInButton setTitle:@"Log In" forState:UIControlStateNormal];
    [self.logInButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.logInButton addTarget:self action:@selector(didTapLoginButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.logInButton];
    
    [self setSignUpButton:[UIButton new]];
    [self.signUpButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [self.signUpButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.signUpButton addTarget:self action:@selector(didTapSignupButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signUpButton];
    
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints {
    [super updateConstraints];
    NSDictionary *views = @{ @"loginButton": self.logInButton,
                             @"signupButton": self.signUpButton };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loginButton(200)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[signupButton(200)]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[loginButton]-10-[signupButton]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

-(void)didTapLoginButton:(id)sender {
    [self.delegate didTapLogInButtonFromButtonView:self];
}

-(void)didTapSignupButton:(id)sender {
    [self.delegate didTapSignUpButtonFromButtonView:self];
}
@end
