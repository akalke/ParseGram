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
//@property NSArray *uploadedPhotos;
//@property NSArray *likedPhotos;
//@property NSArray *following;
//@property NSArray *followedBy;

//create methods for parse to access user info

@end