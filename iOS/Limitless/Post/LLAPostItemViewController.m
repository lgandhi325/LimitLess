//
//  LLAPostItemViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/26/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAPostItemViewController.h"
#import "UIImageView+Scale.h"
#import <Parse/Parse.h>

@interface LLAPostItemViewController ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIImageView *thumbnailImageView;
@property (nonatomic) UITextField *captionTextView;
@property (nonatomic) UIButton *postButton;

@end

@implementation LLAPostItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

-(void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    [super viewDidAppear:animated];
}

- (void) configure {
    [self setScrollView:[UIScrollView new]];
    [self.scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.scrollView setPagingEnabled:YES];
    [self.view addSubview:self.scrollView];
    
    [self setThumbnailImageView:[UIImageView new]];
    [self.thumbnailImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.thumbnailImageView setImage:self.thumbnailImage];
    self.thumbnailImageView.contentMode = UIViewContentModeScaleToFill;
    [self.scrollView addSubview:self.thumbnailImageView];
    
    [self setCaptionTextView:[UITextField new]];
    [self.captionTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.captionTextView setPlaceholder:@"Post an awesome caption"];
    [self.captionTextView setBackgroundColor:[UIColor whiteColor]];
    [self.captionTextView setTextAlignment:NSTextAlignmentCenter];
    [self.scrollView addSubview:self.captionTextView];
    
    [self setPostButton:[UIButton new]];
    [self.postButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.postButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.postButton.titleLabel setTextColor:[UIColor whiteColor]];
    [self.postButton.titleLabel setText:@"Post"];
    [self.postButton setTitle:@"Post" forState:UIControlStateNormal];
    [self.postButton addTarget:self action:@selector(didTapPostButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.postButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void) updateViewConstraints {
    [super updateViewConstraints];
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height*3)];
    
    NSDictionary *viewsDictionary = @{ @"scrollView": self.scrollView,
                                       @"thumbnail": self.thumbnailImageView,
                                       @"caption": self.captionTextView,
                                       @"postButton": self.postButton };
    
    NSDictionary *metrics = @{ @"imageWidth": @(self.scrollView.bounds.size.width) };
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[thumbnail][caption(80)][postButton(30)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[thumbnail(imageWidth)]"
                                                                      options:0
                                                                      metrics:metrics
                                                                        views:viewsDictionary]];
    
    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[caption]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[postButton]-15-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:viewsDictionary]];
    
    [self.scrollView addConstraint:[NSLayoutConstraint constraintWithItem:self.thumbnailImageView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.thumbnailImageView
                                                          attribute:NSLayoutAttributeWidth
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void) didTapPostButton:(id)sender {
    NSData* data = UIImageJPEGRepresentation(self.thumbnailImage, 0.5f);
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:data];
    
    PFObject *newPost = [[PFObject alloc] initWithClassName:@"Post"];
    [newPost setObject:imageFile forKey:@"image"];
    [newPost setObject:[PFUser currentUser] forKey:@"user"];
    [newPost setObject:@(1) forKey:@"type"];
    [newPost setObject:self.captionTextView.text forKey:@"message"];
    [newPost saveInBackgroundWithTarget:self selector:@selector(successfullySaved:error:)];
}

- (void)successfullySaved:(BOOL)succeeded error:(NSError *)error {
    if(error) {
        NSLog(@"Error: %@", error);
    } else {
        NSLog(@"Successfully saved!");
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
