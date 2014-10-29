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
@dynamic imageURL;
@dynamic imageTags;
@dynamic isliked;
@dynamic comments;
@dynamic timeStamp;
@dynamic uploadedBy;
@dynamic likedBy;

+(NSString *)parseClassName{
    return @"Photo";
}

+(void)load{
    [self registerSubclass];
}

@end