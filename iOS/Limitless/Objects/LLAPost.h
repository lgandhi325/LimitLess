//
//  LLAPost.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/11/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface LLAPost : NSObject <PFSubclassing>

@property (nonatomic) PFUser *user;
@property (nonatomic) NSString *message;
@property (nonatomic) PFFile *image;

+ (NSString*) parseClassName;

@end
