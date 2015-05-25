//
//  LLALoginViewController.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/10/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLALoginActionDelegate.h"

@interface LLALoginView : UIView

@property (nonatomic) id<LLALoginActionDelegate> delegate;

@end
