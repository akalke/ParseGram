//
//  User.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface User : PFObject <PFSubclassing>
@property NSString *username;
@property NSString *password;
@property NSString *emailAddress;
@property NSString *photoID;

-(NSString *)getUserID: (NSString *)username;

@end