//
//  LLAParseAdapter.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/18/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAParseAdapter.h"
#import "LLAUser.h"
#import "LLARepository.h"
#import <Parse/Parse.h>

@implementation LLAParseAdapter

-(void)getPostsWithBlock:(void (^)(NSArray *, NSError *))block {
    PFQuery *query = [PFQuery queryWithClassName:@"UserFollows"];
    [query whereKey:@"followedBy" equalTo:[LLAUser currentUser]];
    [query includeKey:@"following"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"getPostsWithBlockCall: %@", error);
        } else {
            NSMutableArray *userList = [NSMutableArray new];
            
            for(PFObject *object in objects) {
                [userList addObject:[object objectForKey:@"following"]];
            }
            
            PFQuery *postsQuery = [PFQuery queryWithClassName:@"Post"];
            [postsQuery whereKey:@"user" containedIn:userList];
            [postsQuery includeKey:@"user"];
            [postsQuery orderByDescending:@"createdAt"];
            [postsQuery findObjectsInBackgroundWithBlock:block];
        }
    }];
}

@end
