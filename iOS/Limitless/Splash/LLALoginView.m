//
//  LLALoginViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/10/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALoginView.h"

@interface LLALoginView ()
@property (nonatomic) IBOutlet UIButton *backButton;
@property (nonatomic) IBOutlet UITextField *usernameField;
@property (nonatomic) IBOutlet UITextField *passwordField;
@property (nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation LLALoginView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self) {
        [self configure];
    }
    return self;
}

- (void) configure {
    [self setBackgroundColor:[UIColor blueColor]];
}

- (IBAction)backButtonTapped:(id)sender {
}


@end
