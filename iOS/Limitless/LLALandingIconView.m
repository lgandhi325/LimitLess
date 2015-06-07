//
//  LLALandingIconView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/25/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLALandingIconView.h"
#import "UIColor+LimitlessColors.h"
#import "UIImageView+Scale.h"

#import <UIImageView+AFNetworking.h>

const CGFloat IMAGE_SIZE = 100.f;

@interface LLALandingIconView()

@property (nonatomic) UIView *imageBackgroundView;
@property (nonatomic) UIImageView *customImageView;
@property (nonatomic) UILabel *labelView;

@property (nonatomic) NSString *customTitle;
@property (nonatomic) UIImage *customImage;
@property (nonatomic) NSURL *imageUrl;

@end

@implementation LLALandingIconView

- (id) initWithTitle:(NSString *)title andImage:(UIImage *)image {
    self = [super init];
    if(self) {
        _customImage = image;
        [self setCustomTitle:title];
        [self configure];
    }
    return self;
}

- (id) initWithTitle:(NSString *)title andImageURL:(NSURL *)imageUrl {
    self = [super init];
    if(self) {
        _imageUrl = imageUrl;
        [self setCustomTitle:title];
        [self configure];
    }
    return self;
}

- (void) configure {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    [self setImageBackgroundView:[UIView new]];
    [self.imageBackgroundView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageBackgroundView setUserInteractionEnabled:NO];
    [self.imageBackgroundView setBackgroundColor:[UIColor limitlessBlueColor]];
    [self addSubview:self.imageBackgroundView];
    
    [self setCustomImageView:[UIImageView new]];
    [self.customImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.customImageView setUserInteractionEnabled:NO];
    [self.customImageView setBackgroundColor:[UIColor clearColor]];
    if(self.customImage) {
        [self.customImageView setImage:self.customImage];
    }
    
    if(self.imageUrl) {
        
        NSURLRequest *imageRequest = [NSURLRequest requestWithURL:self.imageUrl
                                                          cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                      timeoutInterval:60];
        [self.customImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:nil failure:nil];
    }
    [self.customImageView scaleAspectFit:0.5f];
    [self addSubview:self.customImageView];
    
    [self setLabelView:[UILabel new]];
    [self.labelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.labelView setUserInteractionEnabled:NO];
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
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageBackground]"
//                                                                 options:0
//                                                                 metrics:metrics
//                                                                   views:views]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[customImage]"
//                                                                 options:0
//                                                                 metrics:metrics
//                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageBackground]-[label(20)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[customImage]-[label(20)]|"
                                                                 options:0
                                                                 metrics:metrics
                                                                   views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.f
                                                      constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView
                                                     attribute:NSLayoutAttributeHeight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.customImageView
                                                     attribute:NSLayoutAttributeWidth
                                                    multiplier:1.f
                                                      constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.imageBackgroundView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0.f]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.customImageView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.f
                                                      constant:0.f]];
}
@end
