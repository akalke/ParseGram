//
//  User.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "User.h"

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

@end