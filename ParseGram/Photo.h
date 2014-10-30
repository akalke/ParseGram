//
//  Photo.h
//  ParseGram
//
//  Created by Amaeya Kalke on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Photo : PFObject <PFSubclassing>

@property NSString *caption;
@property NSString *imageTags;
@property NSDate *timeStamp;
@property NSString *uploadedBy;

-(void)createPhotoObject: (NSString *)photoCaption :(NSString *)photoTags :(User *)uploadByUser;

@end