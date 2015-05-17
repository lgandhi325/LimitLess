//
//  LLAPostViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/14/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAPostViewController.h"
#import "UIColor+LimitlessColors.h"

const CGFloat sideLength = 50.f;

@interface LLAPostViewController ()
@property (weak, nonatomic) IBOutlet UIView *videoButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *videoButton;

@property (weak, nonatomic) IBOutlet UIView *pictureButtonContainer;
@property (weak, nonatomic) IBOutlet UIButton *pictureButton;

@end

@implementation LLAPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAndConstrainViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initAndConstrainViews {
    [self.videoButtonContainer setClipsToBounds:YES];
    [self.videoButtonContainer.layer setCornerRadius:50.f];
    [self.videoButton setBackgroundColor:[UIColor blackColor]];
    [self.videoButton setClipsToBounds:YES];
    [self.videoButton.layer setCornerRadius:25.f];
    
    [self.pictureButtonContainer setClipsToBounds:YES];
    [self.pictureButtonContainer.layer setCornerRadius:50.f];
    [self.pictureButton setBackgroundColor:[UIColor blackColor]];
    [self.pictureButton setClipsToBounds:YES];
    [self.pictureButton.layer setCornerRadius:25.f];
}

@end
