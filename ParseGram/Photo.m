//
//  Photo.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@dynamic caption;
@dynamic imageTags;
@dynamic timeStamp;
@dynamic uploadedBy;


+(NSString *)parseClassName{
    return @"Photo";
}

+(void)load{
    [self registerSubclass];
}

-(void)createPhotoObject: (NSString *)photoCaption :(NSString *)photoTags :(User *)uploadByUser{
    self.caption = photoCaption;
    self.imageTags = photoTags;
    self.uploadedBy = uploadByUser.objectId;

}

@end