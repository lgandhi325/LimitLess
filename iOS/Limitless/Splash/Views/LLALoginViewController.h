//
//  LLALoginView.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/8/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLALoginActionDelegate.h"

@interface LLALoginViewController : UINavigationController

@property (nonatomic, weak) id<LLALoginActionDelegate> delegate;

@end
