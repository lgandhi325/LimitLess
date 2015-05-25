//
//  LLARepositoryProtocol.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LLARepositoryProtocol <NSObject>

- (void)getPostsWithBlock:(void(^)(NSArray *, NSError *))block;

@end