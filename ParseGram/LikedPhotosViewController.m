//
//  LikedPhotosViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "LikedPhotosViewController.h"
#import "CustomCollectionViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"

@interface LikedPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *likedPhotos;

@end

@implementation LikedPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@'s Liked Photos", self.user];
    // Needs refresh method
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Needs refresh method
}

#pragma mark - CollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
//    return self.likePhotos.count;
}

// Needs to be populated by liked photos based on *user (public property)
// Already set from UserProfile prepare4Segue
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // Photo object to pull data from
    Photo *photo = [self.likedPhotos objectAtIndex:indexPath.row];
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Method below to use photo pointer above for photos
//    PFFile *image = [photo objectForKey:@"image"];
//    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            UIImage *image = [UIImage imageWithData:data];
//            cell.photo.image = image;
//        }
//    }];
    
    cell.photo.image = [UIImage imageNamed:@"stig"];
    // Only have image property for the collectionview
    
    return cell;
}

@end
