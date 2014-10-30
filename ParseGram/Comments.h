//
//  Comments.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/29/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "User.h"
#import "Photo.h"

@class Photo;

@interface Comments : PFObject <PFSubclassing>
@property NSString *photoID;
@property NSString *userID;
@property NSString *comment;
@property NSString *commentDate;

-(void)createComment: (NSString *)addedComment :(User *)commentingUser :(Photo *)photo;
-(NSArray *)grabAllCommentsForUser: (User *)commentingUser;
-(NSArray *)grabAllCommentsForPhoto: (Photo *)photo;

@end
