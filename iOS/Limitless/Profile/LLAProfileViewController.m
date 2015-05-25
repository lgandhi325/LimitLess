//
//  LLAProfileViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAProfileViewController.h"
#import <UIImageView+AFNetworking.h>

@interface LLAProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userRealName;
@property (weak, nonatomic) IBOutlet UILabel *userHandle;
@property (weak, nonatomic) IBOutlet UIImageView *postPreviewOne;
@property (weak, nonatomic) IBOutlet UIImageView *postPreviewTwo;
@property (weak, nonatomic) IBOutlet UIImageView *postPreviewThree;
@property (weak, nonatomic) IBOutlet UIButton *seeAllPostsButton;

@end

@implementation LLAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSURL *url = [NSURL URLWithString:self.user.profileImage.url];
//    NSURLRequest *profileImageRequest = [NSURLRequest requestWithURL:url
//                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                    timeoutInterval:60];
    
//    [self.userProfileImage setImageWithURLRequest:profileImageRequest placeholderImage:nil success:nil failure:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
}

@end
