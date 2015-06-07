//
//  LLASplashButtonView.h
//  Limitless
//
//  Created by Anthony Lipscomb on 6/6/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLASplashDelegates.h"

@interface LLASplashButtonContainerView : UIView

@property (nonatomic) id<LLASplashDelegateButtonView> delegate;

@end
