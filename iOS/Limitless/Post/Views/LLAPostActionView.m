//
//  LLAPostActionView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/31/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAPostActionView.h"
#import "UIColor+LimitlessColors.h"
#import "UIImageView+Scale.h"

@interface LLAPostActionView()

@property (nonatomic) UIImage *iconImage;
@property (nonatomic) UIImageView *iconImageView;
@property (nonatomic) UIView *backingView;
@property (nonatomic) UIView *imageBackingView;

@end

@implementation LLAPostActionView

- (instancetype)initWithImage:(UIImage*)image {
    self = [super init];
    if(self) {
        _iconImage = image;
        [self configure];
    }
    return self;
}

- (void)configure {
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setClipsToBounds:YES];
    [self.layer setCornerRadius:40.f];

    [self setBackingView:[UIView new]];
    [self.backingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.backingView setBackgroundColor:[UIColor limitlessBlueColor]];
    [self.backingView setClipsToBounds:YES];
    [self.backingView.layer setCornerRadius:35.f];
    [self.backingView setUserInteractionEnabled:NO];
    [self addSubview:self.backingView];
    
    [self setImageBackingView:[UIView new]];
    [self.imageBackingView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageBackingView setBackgroundColor:[UIColor blackColor]];
    [self.imageBackingView setClipsToBounds:YES];
    [self.imageBackingView.layer setCornerRadius:30.f];
    [self.imageBackingView setUserInteractionEnabled:NO];
    [self addSubview:self.imageBackingView];
    
    [self setIconImageView:[UIImageView new]];
    [self.iconImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.iconImageView setBackgroundColor:[UIColor blackColor]];
    [self.iconImageView setImage:self.iconImage];
    [self.iconImageView setClipsToBounds:YES];
    [self.iconImageView.layer setCornerRadius:25.f];
    [self.iconImageView scaleAspectFit:0.6f];
    [self.iconImageView setUserInteractionEnabled:NO];
    [self.imageBackingView addSubview:self.iconImageView];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    
    NSDictionary *views = @{ @"imageView": self.iconImageView,
                             @"imageBackingView": self.imageBackingView,
                             @"backingView": self.backingView };
    
    [self.imageBackingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:views]];
    
    [self.imageBackingView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[backingView]-5-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[backingView]-5-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageBackingView]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imageBackingView]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
}

@end
