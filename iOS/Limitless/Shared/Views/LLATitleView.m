//
//  LLATitleView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 6/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLATitleView.h"

@interface LLATitleView()

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;

@end

@implementation LLATitleView

-(instancetype)initWithSubtitle:(NSString *)subtitle {
    self = [super init];
    if(self) {
        _subtitleText = subtitle;
        [self initViews];
    }
    return self;
}

-(void)initViews {
    [self setTitleLabel:[UILabel new]];
    [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel setText:@"Limitless"];
    [self.titleLabel setFont:[UIFont fontWithName:@"Zapfino" size:35.f]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.titleLabel];
    
    [self setSubtitleLabel:[UILabel new]];
    [self.subtitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.subtitleLabel setText:self.subtitleText];
    [self.subtitleLabel setTextColor:[UIColor whiteColor]];
    [self.subtitleLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.subtitleLabel];
    
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints {
    [super updateConstraints];
    NSDictionary *views = @{ @"title": self.titleLabel,
                             @"subtitle": self.subtitleLabel };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[title]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[title]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subtitle]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.subtitleLabel
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.3f
                                                      constant:0.f]];
}

@end
