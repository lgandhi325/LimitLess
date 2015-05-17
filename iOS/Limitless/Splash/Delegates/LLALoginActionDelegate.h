//
//  LLALoginActionDelegate.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/8/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

@class LLALoginView;

@protocol LLALoginActionDelegate

- (void)loginActionRequestedFromView:(LLALoginView*)view asUser:(NSString*)user withPassword:(NSString*)password;

@end
