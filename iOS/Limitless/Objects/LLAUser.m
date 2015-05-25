//
//  LLAUser.m
//  Limitless
//
//  Created by Anthony Lipscomb on 5/17/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import "LLAUser.h"

#define FIRST_NAME_PARSE_KEY @"firstname"
#define LAST_NAME_PARSE_KEY @"lastname"
#define PROFILE_IMAGE_PARSE_KEY @"profileImage"

@implementation LLAUser

@synthesize firstname;
@synthesize lastname;
@synthesize profileImage;

- (NSString *)firstname {
    return [self objectForKey:FIRST_NAME_PARSE_KEY];
}

- (NSString *)lastname {
    return [self objectForKey:LAST_NAME_PARSE_KEY];
}

- (PFFile *)profileImage {
    return [self objectForKey:PROFILE_IMAGE_PARSE_KEY];
}

+(LLAUser *)currentUser {
    return [super currentUser];
}

@end
