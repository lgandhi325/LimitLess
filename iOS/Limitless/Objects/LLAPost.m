//
//  LLAPost.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAPost.h"
#import <Parse/PFObject+Subclass.h>

@implementation LLAPost
+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Post";
}

@end
