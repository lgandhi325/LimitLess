//
//  LLARegistrationView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/24/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLASplashSignUpView.h"
#import "UIColor+LimitlessColors.h"

@interface LLASplashSignUpView()

@property (nonatomic) UIButton *backButton;
@property (nonatomic) UITextField *emailField;
@property (nonatomic) UITextField *firstnameField;
@property (nonatomic) UITextField *lastnameField;
@property (nonatomic) UITextField *usernameField;
@property (nonatomic) UITextField *passwordField;
@property (nonatomic) UIButton *signUpButton;

@end

@implementation LLASplashSignUpView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configure];
    }
    return self;
}

- (void) configure {
    [self setBackButton:[UIButton new]];
    [self.backButton setBackgroundColor:[UIColor blueColor]];
    [self.backButton.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    [self.backButton setTitle:NSLocalizedString(@"Back", nil) forState:UIControlStateNormal];
    [self.backButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.backButton addTarget:self action:@selector(onBackTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    [self setEmailField:[self generateTextField]];
    [self.emailField setPlaceholder:NSLocalizedString(@"Email address",nil)];
    [self addSubview:self.emailField];
    
    [self setFirstnameField:[self generateTextField]];
    [self.firstnameField setPlaceholder:NSLocalizedString(@"First name", nil)];
    [self addSubview:self.firstnameField];
    
    [self setLastnameField:[self generateTextField]];
    [self.lastnameField setPlaceholder:NSLocalizedString(@"Last name", nil)];
    [self addSubview:self.lastnameField];
    
    [self setUsernameField:[self generateTextField]];
    [self.usernameField setPlaceholder:NSLocalizedString(@"Username", nil)];
    [self addSubview:self.usernameField];
    
    [self setPasswordField:[self generateTextField]];
    [self.passwordField setPlaceholder:NSLocalizedString(@"Password", nil)];
    [self addSubview:self.passwordField];
    
    [self setSignUpButton:[UIButton new]];
    [self.signUpButton.titleLabel setText:@"Sign Up"];
    [self.signUpButton addTarget:self action:@selector(onSignUpTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.signUpButton];
    
    [self setNeedsUpdateConstraints];
}

- (void) updateConstraints {
    [super updateConstraints];
    NSDictionary *viewsDictionary = @{ @"backButton": self.backButton,
                                       @"emailField": self.emailField,
                                       @"firstnameField": self.firstnameField,
                                       @"lastnameField": self.lastnameField,
                                       @"usernameField": self.usernameField,
                                       @"passwordField": self.passwordField,
                                       @"signUpButton": self.signUpButton
                                       };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backButton]-[emailField]-[firstnameField]-[usernameField]-[passwordField]-[signUpButton]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[backButton]-[emailField]-[lastnameField]-[usernameField]-[passwordField]-[signUpButton]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[backButton]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[emailField]-15-|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[firstnameField]-10-[lastnameField]-15-|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[usernameField]-15-|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[passwordField]-15-|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[signUpButton]-15-|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
}

- (void) onBackTapped:(id)sender {
    [self.delegate backActionRequestedFromSignUpView:self];
}

- (void) onSignUpTapped:(id)sender {
    NSString *email = [self.emailField text];
    NSString *firstname = [self.firstnameField text];
    NSString *lastname = [self.lastnameField text];
    NSString *username = [self.usernameField text];
    NSString *password = [self.passwordField text];

    //TODO: Validation
    
    [self.delegate signUpActionRequestedFromSignUpView:self withEmail:email firstname:firstname lastname:lastname asUser:username withPassword:password];
}

- (UITextField *) generateTextField {
    UITextField *generatedField = [UITextField new];
    
    [generatedField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [generatedField setTextAlignment:NSTextAlignmentCenter];
    [generatedField setBackgroundColor:[UIColor whiteColor]];
    [generatedField setTextColor:[UIColor limitlessBlueColor]];
    
    return generatedField;
}

@end
