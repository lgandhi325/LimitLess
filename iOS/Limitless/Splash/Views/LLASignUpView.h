//
//  LLARegistrationView.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/24/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLASignUpActionDelegate.h"

@interface LLASignUpView : UIView

@property (nonatomic) id<LLASignUpActionDelegate> delegate;

@end
