//
//  LLASignUpActionDelegate.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/24/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

@class LLASignUpView;

@protocol LLASignUpActionDelegate

- (void)signUpActionRequestedFromSignUpView:(LLASignUpView*)view withEmail:(NSString*)email firstname:(NSString *)firstname lastname:(NSString *)lastname asUser:(NSString*)user withPassword:(NSString*)password;

- (void)backActionRequestedFromSignUpView:(LLASignUpView*)view;

@end
