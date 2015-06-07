//
//  UIImageView+Scale.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/27/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "UIImageView+Scale.h"

@implementation UIImageView (Scale)

-(void) scaleAspectFit:(CGFloat) scaleFactor{
    self.contentScaleFactor = scaleFactor;
    self.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    
    CGRect newRect = self.frame;
    newRect.origin.x = 0;
    newRect.origin.y = 0;
    self.frame = newRect;
}

@end