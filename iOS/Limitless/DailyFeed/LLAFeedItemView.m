//
//  LLAFeedItemView.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAFeedItemView.h"
#import "UIColor+LimitlessColors.h"
#import <AFNetworking/AFNetworking.h>

@interface LLAFeedItemView()
@property (nonatomic) UIImageView *primaryImageView;
@property (nonatomic) UIView *dividerView;
@property (nonatomic) UIImageView *userImageView;

@end

@implementation LLAFeedItemView


//- (void) configure {
//    [self setPrimaryImageView:[[UIImageView alloc] initWithFrame:self.bounds]];
//    [self.primaryImageView setImage:[UIImage imageNamed:@"FullSizeRender"]];
//    [self.primaryImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self addSubview:self.primaryImageView];
//    
//    [self setDividerView:[UIView new]];
//    [self.dividerView setBackgroundColor:[UIColor limitlessBlueColor]];
//    [self.dividerView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self addSubview:self.dividerView];
//    
//    [self setUserImageView:[[UIImageView alloc] initWithFrame:self.bounds]];
//    [self.primaryImageView setImage:[UIImage imageNamed:@"FullSizeRender"]];
//    [self.userImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [self addSubview:self.primaryImageView];
//    
//    NSDictionary *viewsDictionary = @{ @"imageView": self.primaryImageView,
//                                       @"userImage": self.userImageView,
//                                       @"dividerView": self.dividerView };
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView][dividerView(1)][userImage(50)]|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dividerView]|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[userImage(50)]|"
//                                                                 options:0
//                                                                 metrics:nil
//                                                                   views:viewsDictionary]];
//}

@end
