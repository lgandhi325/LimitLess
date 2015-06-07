//
//  LLAFeedItemDetailsViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 6/4/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAFeedItemDetailsViewController.h"

@interface LLAFeedItemDetailsViewController ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *postImageVIew;
@property (nonatomic) UILabel *captionLabel;

@end

@implementation LLAFeedItemDetailsViewController

- (void) configure {
    [self setScrollView:[UIScrollView new]];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.scrollView];
    
    [self setPostImageVIew:[UIImageView new]];
    [self.postImageVIew setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.postImageVIew setImage:self.postImage];
    [self.scrollView addSubview:self.postImageVIew];
    
    [self setCaptionLabel:[UILabel new]];
    [self.captionLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.captionLabel setText:self.captionText];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    [self.view setNeedsUpdateConstraints];
}

-(void)updateViewConstraints {
    NSDictionary *viewsDictionary = @{ @"image": self.postImage,
                                       @"caption": self.captionLabel };
    
    
}

@end
