//
//  LLARepository.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "AppDelegate.h"
#import "LLARepository.h"
#import "LLAParseAdapter.h"
#import "LLARepositoryProtocol.h"

@interface LLARepository ()

@property (nonatomic, strong) id<LLARepositoryProtocol> adapter;

@end

@implementation LLARepository

-(id)init {
    self = [super init];
    if(self) {
        self.adapter = [LLAParseAdapter new];
    }
    return self;
}

+ (id) default {
    static LLARepository *defaultRepository = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultRepository = [[self alloc] init];
    });
    return defaultRepository;
}

- (LLAUser *)user {
    return [LLAUser currentUser];
}

- (void) postsWithBlock:(void(^)(NSArray *, NSError *))block {
    [self.adapter getPostsWithBlock:block];
}

@end
