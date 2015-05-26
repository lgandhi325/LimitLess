//
//  LLADailyFeedViewController.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/7/15.
//  Copyright (c) 2015 . All rights reserved.
//

#import "LLADailyFeedViewController.h"
#import "LLAPostViewController.h"

const CGFloat infoBarHeight = 50.f;

@interface LLADailyFeedViewController ()
@property (weak, nonatomic) IBOutlet UIView *topDividerView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation LLADailyFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)postButtonTapped:(id)sender {
    LLAPostViewController *dfvc = [LLAPostViewController new];
    self.definesPresentationContext = YES; //self is presenting view controller
    dfvc.view.backgroundColor = [UIColor clearColor];
    dfvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:dfvc animated:YES completion:nil];
}

@end
