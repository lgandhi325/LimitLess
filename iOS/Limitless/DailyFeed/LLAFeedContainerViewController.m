//
//  LLAFeedContainerViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAFeedContainerViewController.h"
#import "LLAFeeditemViewController.h"
#import "UIView+Toast.h"
#import <Parse/Parse.h>

@interface LLAFeedContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *topDividerView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) UIPageViewController *pageController;
@property (nonatomic) NSArray *posts;

@end

@implementation LLAFeedContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self retrieveData];
    [self configurePageContoller];
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) retrieveData {
    PFQuery *query = [PFQuery queryWithClassName:@"UserFollows"];
    [query whereKey:@"followedBy" equalTo:[PFUser currentUser]];
    [query includeKey:@"following"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            
        } else {
            NSMutableArray *userList = [NSMutableArray new];
            
            for(PFObject *object in objects) {
                [userList addObject:[object objectForKey:@"following"]];
            }
            
            PFQuery *postsQuery = [PFQuery queryWithClassName:@"Post"];
            [postsQuery whereKey:@"user" containedIn:userList];
            [postsQuery includeKey:@"user"];
            [postsQuery orderByDescending:@"createdAt"];
            [postsQuery findObjectsInBackgroundWithBlock:^(NSArray *postObjects, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    [self setPosts:postObjects];
                    [self.pageController reloadInputViews];
                }
            }];
        }
    }];
}

- (void)configurePageContoller {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    
    CGRect frame = self.view.bounds;
    frame.origin.y = self.topDividerView.frame.origin.y + self.topDividerView.frame.size.height;
    frame.size.height = self.view.bounds.size.height - frame.origin.y;
    [[self.pageController view] setFrame:frame];
    
    LLAFeedItemViewController *viewControllerObject = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:viewControllerObject];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    
    [[self view] addSubview:[self.pageController view]];
    
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [(LLAFeedItemViewController *)viewController indexNumber];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [(LLAFeedItemViewController *)viewController indexNumber];
    
    index++;
    
    if (index == self.posts.count) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (LLAFeedItemViewController *) viewControllerAtIndex:(NSInteger)index {
    
    LLAFeedItemViewController *vc = [LLAFeedItemViewController new];
    [vc setIndexNumber:index];
    [vc setPostObject:self.posts[index]];
    return vc;
}

@end
