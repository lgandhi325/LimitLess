//
//  LLALoginView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/8/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALoginViewController.h"
#import "UIColor+LimitlessColors.h"

@interface LLALoginViewController ()
@property (nonatomic) UIButton *backButton;
@property (nonatomic) UITextField *usernameField;
@property (nonatomic) UITextField *passwordField;
@property (nonatomic) UIButton *loginButton;

@end

@implementation LLALoginViewController

- (void)viewDidLoad {
    [self configure];
}

- (void) configure {
    [self initializeViews];
    [self constrainViews];
}

- (void) initializeViews {
    [self setBackButton:[UIButton new]];
    [self.backButton setTitle:@"back" forState:UIControlStateNormal];
    [self.backButton setTitleColor:[UIColor limitlessBlueColor] forState:UIControlStateNormal];
    [self.backButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.backButton];
    
    [self setUsernameField:[UITextField new]];
    [self.usernameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.usernameField];
    
    [self setPasswordField:[UITextField new]];
    [self.passwordField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.passwordField];
    
    [self setLoginButton:[UIButton new]];
    [self.loginButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.loginButton];
}

- (void) addTapGestureRecognizer {
    UIGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(backButtonTapped:)];
    [self.backButton addGestureRecognizer:tapGR];
}

- (void)backButtonTapped:(UIGestureRecognizer *)sender {
    NSLog(@"%@",sender);
}

- (void)constrainViews {
    NSDictionary *viewsDictionary = @{ @"backButton": self.backButton,
                                       @"username": self.usernameField,
                                       @"password": self.passwordField,
                                       @"loginButton": self.loginButton };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[backButton][username][password][loginButton]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewsDictionary]];
    
    
}
@end
