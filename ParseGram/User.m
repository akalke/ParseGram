//
//  User.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "User.h"

@interface User ()
@property NSString *userID;
@end

@implementation User

@dynamic username;
@dynamic password;
@dynamic emailAddress;

+(NSString *)parseClassName{
    return @"User";
}

+(void)load{
    [self registerSubclass];
}

-(NSString *)getUserID: (NSString *)username{
    PFQuery *userQuery = [PFQuery queryWithClassName:[User parseClassName]];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error) {
            NSLog(@"%@", error);
            self.userID = @"";
        }
        else{
            self.userID = [objects firstObject];
        }
    }];
    return self.userID;
}

@end