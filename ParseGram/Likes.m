//
//  Likes.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/29/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "Likes.h"

@interface Likes ()
@property NSArray *likesByUser;
@property NSArray *likesByPhoto;
@end


@implementation Likes

@dynamic userID;
@dynamic photoID;

+(NSString *)parseClassName{
    return @"Likes";
}

+(void)load{
    [self registerSubclass];
}

-(void)logPhotoLike: (User *)likedByUser :(Photo *)photo{
    self.userID = likedByUser.objectId;
    self.photoID = photo.objectId;
}

-(NSArray *)grabAllLikesForUser: (User *)likingUser{
    NSPredicate *findUserPredicate = [NSPredicate predicateWithFormat:@"userID = %@", likingUser.objectId];
    PFQuery *likesForUserQuery = [PFQuery queryWithClassName:[Likes parseClassName] predicate:findUserPredicate];
    [likesForUserQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"%@", error);
            NSArray *array =[[NSArray alloc] init];
            self.likesByUser = array;
        }
        else{
            self.likesByUser = objects;
        }
    }];
    return self.likesByUser;
}


-(NSArray *)grabAllLikeForPhoto: (Photo *)photo{
    NSPredicate *findPhotoPredicate = [NSPredicate predicateWithFormat:@"photoID = %@", photo.objectId];
    PFQuery *likesForPhotoQuery = [PFQuery queryWithClassName:[Likes parseClassName] predicate:findPhotoPredicate];
    [likesForPhotoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"%@", error);
            NSArray *array =[[NSArray alloc] init];
            self.likesByPhoto = array;
        }
        else{
            self.likesByPhoto = objects;
        }
    }];
    return self.likesByPhoto;
}

@end
