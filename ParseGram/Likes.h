//
//  Likes.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/29/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>


@interface Likes : PFObject <PFSubclassing>

@property NSString *userID;
@property NSString *photoID;

-(void)logPhotoLike: (User *)likedByUser :(Photo *)photo;
-(NSArray *)grabAllLikesForUser: (User *)likingUser;
-(NSArray *)grabAllCommentsForPhoto: (Photo *)photo;


@end
