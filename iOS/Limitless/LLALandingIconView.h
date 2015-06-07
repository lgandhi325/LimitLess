//
//  LLALandingIconView.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/25/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLALandingIconView : UIButton

- (id) initWithTitle:(NSString *)title andImage:(UIImage *)image;
- (id) initWithTitle:(NSString *)title andImageURL:(NSURL *)imageUrl;

@end
