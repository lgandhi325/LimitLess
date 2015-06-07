//
//  LLALoginActionDelegate.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/8/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

@class LLASplashLoginView;
@class LLASplashSignUpView;
@class LLASplashButtonContainerView;

@protocol LLALoginActionDelegate

- (void)loginActionRequestedFromLoginView:(LLASplashLoginView*)view asUser:(NSString*)user withPassword:(NSString*)password;
- (void)backActionRequestedFromLoginView:(LLASplashLoginView*)view;

@end

@protocol LLASplashDelegateButtonView

-(void)didTapLogInButtonFromButtonView:(LLASplashButtonContainerView *)buttonView;
-(void)didTapSignUpButtonFromButtonView:(LLASplashButtonContainerView *)buttonView;

@end

@protocol LLASignUpActionDelegate

- (void)signUpActionRequestedFromSignUpView:(LLASplashSignUpView*)view withEmail:(NSString*)email firstname:(NSString *)firstname lastname:(NSString *)lastname asUser:(NSString*)user withPassword:(NSString*)password;
- (void)backActionRequestedFromSignUpView:(LLASplashSignUpView*)view;

@end