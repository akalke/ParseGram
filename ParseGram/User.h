//
//  User.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property NSString *userID;
@property NSString *username;
@property NSString *password;
@property NSArray *uploadedPhotos;
@property NSArray *likedPhotos;
@property NSArray *following;
@property NSArray *followedBy;

//create methods for parse to access user info

@end
