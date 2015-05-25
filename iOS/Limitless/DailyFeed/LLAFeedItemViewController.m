//
//  LLAFeedItemViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAFeedItemViewController.h"
#import "LLAUser.h"
#import <UIImageView+AFNetworking.h>
#import <Parse/Parse.h>

@interface LLAFeedItemViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UIImageView *opImage;
@property (weak, nonatomic) IBOutlet UIButton *flipButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation LLAFeedItemViewController

- (IBAction)flipButtonTapped:(id)sender {
    UIView *flippedView = [[UIView alloc] initWithFrame:self.postImage.frame];
    [flippedView setBackgroundColor:[UIColor blueColor]];
    
    [UIView transitionFromView:self.postImage
                        toView:nil
                      duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                    }
     ];
}
- (IBAction)likeButtonTapped:(id)sender {
    if(self.likeButton.selected) {
        [self.likeButton setImage:[UIImage imageNamed:@"Star-Unselected"] forState:UIControlStateNormal];
        [self.likeButton setSelected:NO];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"Star-Selected"] forState:UIControlStateNormal];
        [self.likeButton setSelected:YES];
    }
    [self upvote:self.likeButton.selected];
}

- (void) upvote:(BOOL)selected {
    __weak typeof(self) weakSelf = self;
    LLAUser *user = [LLAUser currentUser];
    PFQuery *upvoteExistsQuery = [PFQuery queryWithClassName:@"PostUpvotes"];
    [upvoteExistsQuery whereKey:@"post" equalTo:self.postObject];
    [upvoteExistsQuery whereKey:@"user" equalTo:user];
    [upvoteExistsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"%@", error);
            return;
        }
        
        if(objects.count == 0) {
            PFObject *upvote = [PFObject object];
            [upvote setObject:user forKey:@"user"];
            [upvote setObject:weakSelf.postObject forKey:@"post"];
            [upvote saveInBackground];
        } else {
            if(!selected) {
                PFObject *upvoteObject = objects[0];
                [upvoteObject deleteInBackground];
            }
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFFile *mainFile = (PFFile*)[self.postObject objectForKey:@"image"];
    LLAUser *poster = (LLAUser*)[self.postObject objectForKey:@"user"];
    
    NSURLRequest *postImageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:mainFile.url]
                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                  timeoutInterval:60];
    
    NSURLRequest *posterImageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:poster.profileImage.url]
                                                      cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                  timeoutInterval:60];
    
    [self.postImage setImageWithURLRequest:postImageRequest placeholderImage:nil success:nil failure:nil];
    [self.opImage setImageWithURLRequest:posterImageRequest placeholderImage:nil success:nil failure:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
