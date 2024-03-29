//
//  LLAFeedContainerViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAFeedContainerViewController.h"
#import "LLAFeeditemViewController.h"
#import "LLADailyTickerViewController.h"
#import "LLALoadingViewController.h"
#import "LLAUser.h"
#import "LLARepository.h"
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
    
    [self setPosts:[NSMutableArray new]];
    
    [self configurePageContoller];
    [self retrieveData];
}

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) retrieveData {
    __weak typeof(self) weakSelf = self;
    [[LLARepository default] postsWithBlock:^(NSArray *data, NSError *error) {
        weakSelf.posts = data;
        UIViewController *viewControllerObject = [weakSelf viewControllerAtIndex:0];
        [weakSelf.pageController setViewControllers:[NSArray arrayWithObject:viewControllerObject]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    }];
}

- (void)configurePageContoller {
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageController.dataSource = self;
    
    CGRect frame = self.view.frame;
    frame.origin.y = self.topDividerView.frame.origin.y + self.topDividerView.frame.size.height + 20.f;
    frame.size.height = self.view.bounds.size.height - frame.origin.y - 20.f;
    [[self.pageController view] setFrame:frame];
    
    UIViewController *viewControllerObject = [LLALoadingViewController new];
    [self.pageController setViewControllers:[NSArray arrayWithObject:viewControllerObject]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];

    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
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

- (UIViewController *) viewControllerAtIndex:(NSInteger)index {
    if(index == 0) {
        LLADailyTickerViewController *dtvc = [LLADailyTickerViewController new];
        return dtvc;
    } else {
        LLAFeedItemViewController *vc = [LLAFeedItemViewController new];
        [vc setIndexNumber:index];
        [vc setPostObject:self.posts[index]];
        return vc;
    }
}

@end
