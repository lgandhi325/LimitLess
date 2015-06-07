//
//  LLAProfileViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAProfileViewController.h"
#import "SplashViewController.h"
#import "UIColor+LimitlessColors.h"
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
@property (weak, nonatomic) IBOutlet UIButton *signOutButton;
@property (weak, nonatomic) IBOutlet UIView *titleUnderlineView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;

@end

@implementation LLAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void) configure {
    [self setUserProfileImage];
    
    NSString *firstname = (NSString *) [[PFUser currentUser] objectForKey:@"firstname"];
    NSString *lastname = (NSString *) [[PFUser currentUser] objectForKey:@"lastname"];
    NSString *username = (NSString *) [[PFUser currentUser] objectForKey:@"username"];
    
    [self.userRealName setText:[NSString stringWithFormat:@"%@ %@", firstname, lastname]];
    [self.userHandle setText:[NSString stringWithFormat:@"@%@", username]];
    
    [self initializeFollowButton];
    [self getLastPosts];
}

- (void) setUserProfileImage {
    PFFile *userImageFile = (PFFile*) [[PFUser currentUser] objectForKey:@"profileImage"];
    [self setNetworkImage:self.userProfileImage fromUrlString:[userImageFile url]];
}

- (void) setNetworkImage:(UIImageView *)imageView fromUrlString:(NSString *) urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *profileImageRequest = [NSURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                     timeoutInterval:60];
    
    [imageView setImageWithURLRequest:profileImageRequest placeholderImage:nil success:nil failure:nil];
}

- (void) initializeFollowButton {
    [self.followButton setHidden:YES];
    if([[[PFUser currentUser] username] isEqual:[self.user username]]) {
        [self.followButton setHidden:YES];
    } else {
        PFQuery *followQuery = [PFQuery queryWithClassName:@"UserFollows"];
        [followQuery whereKey:@"followedBy" equalTo:[PFUser currentUser]];
        [followQuery findObjectsInBackgroundWithTarget:self selector:@selector(finalizeFollowButton:error:)];
    }
}

- (void) finalizeFollowButton:(NSArray *)objects error:(NSError *)error {
    if(error) {
        NSLog(@"%@", error);
    } else {
        for(int n = 0; n < objects.count; n++) {
            PFObject *current = objects[n];
            
            if([current.objectId isEqual:self.user.objectId]) {
                [self.followButton setHidden:NO];
                return;
            }
        }
    }
}

- (void) getLastPosts {
    [self.seeAllPostsButton setHidden:YES];
    
    PFQuery *postsQuery = [PFQuery queryWithClassName:@"Post"];
    [postsQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [postsQuery setLimit:3];
    [postsQuery orderByDescending:@"createdAt"];
    
    __weak typeof(self) weakSelf = self;
    [postsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(objects.count == 0) {
            [weakSelf.seeAllPostsButton setHidden:YES];
            return;
        }
        
        for(int n = 0; n < objects.count; n++) {
            PFFile *imageFile = (PFFile *) [objects[n] objectForKey:@"image"];
            
            // TODO: Clean this up
            switch (n) {
                case 0:
                    [weakSelf setNetworkImage:weakSelf.postPreviewOne fromUrlString:[imageFile url]];
                    break;
                case 1:
                    [weakSelf setNetworkImage:weakSelf.postPreviewTwo fromUrlString:[imageFile url]];
                    break;
                case 2:
                    [weakSelf setNetworkImage:weakSelf.postPreviewTwo fromUrlString:[imageFile url]];
                    break;
                default:
                    break;
            }
        }
    }];
}
- (IBAction)followButtonTapped:(id)sender {
    
}

- (IBAction)signOutButtonTapped:(id)sender {
    [LLAUser logOut];
    SplashViewController *svc = [SplashViewController new];
    [self.navigationController pushViewController:svc animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)seeAllPostsButtonTapped:(id)sender {
    
}
@end
