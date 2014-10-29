//
//  Photo.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <Parse/Parse.h>

@interface Photo : PFObject <PFSubclassing>

@property NSString *photoID;
@property NSString *caption;
@property NSURL *imageURL;
@property NSString *imageTags;
@property BOOL isliked;
@property NSArray *comments;
@property NSDate *timeStamp;
@property NSString *uploadedBy;
@property NSArray *likedBy;

//create methods for parse to access photo info

@end