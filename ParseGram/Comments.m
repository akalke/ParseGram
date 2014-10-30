//
//  Comments.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/29/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "Comments.h"

@interface Comments ()
@property NSArray *commentsByUser;
@property NSArray *commentsByPhoto;
@end

@implementation Comments
@dynamic photoID;
@dynamic userID;
@dynamic comment;
@dynamic commentDate;

+(NSString *)parseClassName{
    return @"Comments";
}

+(void)load{
    [self registerSubclass];
}

-(void)createComment: (NSString *)addedComment :(User *)commentingUser :(Photo *)photo{
    self.comment = addedComment;
    self.userID = commentingUser.objectId;
    self.photoID = photo.objectId;

    NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MM-YY HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currDate];

    self.commentDate = dateString;
}

-(NSArray *)grabAllCommentsForUser: (User *)commentingUser{
    NSPredicate *findUserPredicate = [NSPredicate predicateWithFormat:@"userID = %@", commentingUser.objectId];
    PFQuery *commentsForUserQuery = [PFQuery queryWithClassName:[Comments parseClassName] predicate:findUserPredicate];
    [commentsForUserQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"%@", error);
            NSArray *array =[[NSArray alloc] init];
            self.commentsByUser = array;
        }
        else{
            self.commentsByUser = objects;
        }
    }];
    return self.commentsByUser;
}


-(NSArray *)grabAllCommentsForPhoto: (Photo *)photo{
    NSPredicate *findPhotoPredicate = [NSPredicate predicateWithFormat:@"photoID = %@", photo.objectId];
    PFQuery *commentsForPhotoQuery = [PFQuery queryWithClassName:[Comments parseClassName] predicate:findPhotoPredicate];
    [commentsForPhotoQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"%@", error);
            NSArray *array =[[NSArray alloc] init];
            self.commentsByPhoto = array;
        }
        else{
            self.commentsByPhoto = objects;
        }
    }];
    return self.commentsByPhoto;
}

@end
