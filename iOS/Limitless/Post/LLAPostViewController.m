//
//  LLAPostViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/14/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAPostViewController.h"
#import "LLAPostItemViewController.h"
#import "LLAPostActionView.h"
#import "UIColor+LimitlessColors.h"
#import "UIImageView+Scale.h"

#define ICON_SIZE 80.f
const CGFloat sideLength = 50.f;

@interface LLAPostViewController ()

@property (nonatomic) UIView *container;
@property (nonatomic) UILabel *postTitle;
@property (nonatomic) LLAPostActionView *imageButton;
@property (nonatomic) LLAPostActionView *videoButton;

@end

@implementation LLAPostViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        [self initAndConstrainViews];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) initAndConstrainViews {
    [self setContainer:[UIView new]];
    [self.container setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.container];
    
    [self setPostTitle:[UILabel new]];
    [self.postTitle setText:@"Inspire by example"];
    [self.postTitle setTextColor:[UIColor whiteColor]];
    [self.postTitle setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:self.postTitle];
    
    [self setImageButton:[[LLAPostActionView alloc] initWithImage:[UIImage imageNamed:@"Picture"]]];
    [self.imageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imageButton addTarget:self action:@selector(didTapImageButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.imageButton];
    
    [self setVideoButton:[[LLAPostActionView alloc] initWithImage:[UIImage imageNamed:@"Video"]]];
    [self.videoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.videoButton addTarget:self action:@selector(didTapVideoButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.container addSubview:self.videoButton];
    
    [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    
    NSDictionary *views = @{ @"container": self.container,
                             @"postTitle": self.postTitle,
                             @"imageItem": self.imageButton,
                             @"videoItem": self.videoButton };
    
    NSDictionary *metrics = @{ @"iconSize": @(ICON_SIZE) };
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageItem(iconSize)]-20-[videoItem(iconSize)]|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[videoItem(iconSize)]|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageItem(iconSize)]|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.container
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void)didTapImageButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)didTapVideoButton:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //Or you can get the image url from AssetsLibrary
    //    NSURL *path = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    LLAPostItemViewController *pivc = [LLAPostItemViewController new];
    [pivc setThumbnailImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:pivc animated:YES completion:nil];
}

@end
