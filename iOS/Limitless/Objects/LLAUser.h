//
//  LLAUser.h
//  Limitless
//
//  Created by Anthony Lipscomb on 5/17/15.
//  Copyright (c) 2015 Honycomb. All rights reserved.
//

#import <Parse/Parse.h>

@interface LLAUser : PFUser

@property (nonatomic) NSString *firstname;
@property (nonatomic) NSString *lastname;
@property (nonatomic) PFFile *profileImage;

+ (LLAUser *)currentUser;

@end
