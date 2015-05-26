//
//  LLALandingIconView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/25/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALandingIconView.h"
#import "UIColor+LimitlessColors.h"

const CGFloat IMAGE_SIZE = 100.f;

@interface LLALandingIconView()

@property (nonatomic) UIView *imageBackgroundView;
@property (nonatomic) UIImageView *customImageView;
@property (nonatomic) UILabel *labelView;

@property (nonatomic) NSString *customTitle;
@property (nonatomic) UIImage *customImage;

@end

@implementation LLALandingIconView

- (id) initWithTitle:(NSString *)title andImage:(UIImage *)image {
    self = [super init];
    if(self) {
        [self setCustomImage:image];
        [self setCustomTitle:title];
        [self configure];
    }
    return self;
}

- (void) configure {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self setImageBackgroundView:[UIView new]];
    [self.imageBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageBackgroundView setBackgroundColor:[UIColor limitlessBlueColor]];
    [self addSubview:self.imageBackgroundView];
    
    [self setCustomImageView:[UIImageView new]];
    [self.customImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customImageView setBackgroundColor:[UIColor clearColor]];
    //[self.customImageView setImage:self.customImage];
    [self addSubview:self.customImageView];
    
    [self setLabelView:[UILabel new]];
    [self.labelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelView setText:self.customTitle];
    [self.labelView setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:self.labelView];
    
    [self constrainViews];
}

- (void) constrainViews {
    NSDictionary *views = @{ @"imageBackground": self.imageBackgroundView,
                             @"customImage": self.customImageView,
                             @"label": self.labelView
                             };
    
    NSDictionary *metrics = @{ @"imageSize": @(IMAGE_SIZE) };
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[imageBackground]-10-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[customImage]-10-|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[imageBackground]-[label]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[customImage]-[label]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
}
@end
