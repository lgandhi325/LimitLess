//
//  LLARepository.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLAUser.h"
#import "LLAPost.h"

@interface LLARepository : NSObject

+ (id) default;

- (LLAUser *) user;
- (void) postsWithBlock:(void (^)(NSArray *, NSError *))block;

@end
