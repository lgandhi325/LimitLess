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
@property (weak, nonatomic) IBOutlet UIView *contentArea;
@property (nonatomic) BOOL flipped;
@property (weak, nonatomic) IBOutlet UIButton *postButton;

@end

@implementation LLADailyFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postImageTapped:(UIGestureRecognizer *)sender {
    
}
- (IBAction)postButtonTapped:(id)sender {
    LLAPostViewController *dfvc = [LLAPostViewController new];
    self.definesPresentationContext = YES; //self is presenting view controller
    dfvc.view.backgroundColor = [UIColor clearColor];
    dfvc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:dfvc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
