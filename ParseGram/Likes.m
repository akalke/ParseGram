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

-(void)logPhotoLike: (NSString *)likedByUserID :(NSString *)photoID{
    self.userID = likedByUserID;
    self.photoID = photoID;

    [self saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            NSLog(@"Image liked");
        }
    }];
}

-(NSArray *)grabAllLikesForUser: (NSString *)likingUserID{
    NSPredicate *findUserPredicate = [NSPredicate predicateWithFormat:@"userID = %@", likingUserID];
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


-(NSArray *)grabAllLikesForPhoto: (NSString *)photoID{
    NSPredicate *findPhotoPredicate = [NSPredicate predicateWithFormat:@"photoID = %@", photoID];
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
