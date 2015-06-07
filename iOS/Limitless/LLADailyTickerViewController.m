//
//  LLADailyTickerViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/27/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLADailyTickerViewController.h"

#define DailyQuoteMessage @"\"There's greatness in you.\n\nUnleash it.\""
#define DailyTickerHeader @"The Daily Ticker:"

@interface LLADailyTickerViewController ()

@property (nonatomic) UILabel *headerLabel;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UITextField *response;
@property (nonatomic) UIButton *postButton;

@end

@implementation LLADailyTickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    [self setHeaderLabel:[UILabel new]];
    [self.headerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.headerLabel setText:DailyTickerHeader];
    [self.headerLabel setTextColor:[UIColor whiteColor]];
    [self.headerLabel setFont:[UIFont boldSystemFontOfSize:30.f]];
    [self.headerLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.headerLabel];
    
    [self setMessageLabel:[UILabel new]];
    [self.messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.messageLabel setNumberOfLines:0];
    [self.messageLabel setFont:[UIFont systemFontOfSize:50.f]];
    [self.messageLabel setText:DailyQuoteMessage];
    [self.messageLabel setTextColor:[UIColor whiteColor]];
    [self.messageLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.messageLabel];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *viewsDict = @{ @"headerLabel": self.headerLabel,
                                 @"messageLabel": self.messageLabel };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[messageLabel]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDict]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(40)-[headerLabel]-(50)-[messageLabel]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDict]];
}

@end
