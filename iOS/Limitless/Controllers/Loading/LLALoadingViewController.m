//
//  LLALoadingViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/31/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALoadingViewController.h"

@interface LLALoadingViewController ()

@property (nonatomic) UIView *containerView;
@property (nonatomic) UIProgressView *loadingIndicator;
@property (nonatomic) UILabel *label;

@end

@implementation LLALoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void)configure {
    [self setContainerView:[UIView new]];
    [self.containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.containerView];
    
    [self setLoadingIndicator:[UIProgressView new]];
    [self.loadingIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.containerView addSubview:self.loadingIndicator];
    
    [self setLabel:[UILabel new]];
    [self.label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.label setTextAlignment:NSTextAlignmentCenter];
    [self.label setText:self.labelText];
    [self.containerView addSubview:self.label];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    NSDictionary *viewDictionary = @{ @"containerView": self.containerView,
                                      @"loadingView": self.loadingIndicator,
                                      @"labelView": self.label };
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[loadingView(50)][labelView]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDictionary]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loadingView(50)]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDictionary]];
    
    [self.containerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[labelView]|"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDictionary]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.containerView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

@end
