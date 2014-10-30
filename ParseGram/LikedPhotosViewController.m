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
#import "Likes.h"

@interface LikedPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property NSArray *likedPhotos;
@property NSString *userID;

@end

@implementation LikedPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@'s Liked Photos", self.user];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.userID = [userDefaults stringForKey:@"CURRENT_USER_ID"];
    [self refreshView];
}

#pragma mark - CollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.likedPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Likes *like = [self.likedPhotos objectAtIndex:indexPath.row];
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId = %@", like.photoID];
    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName] predicate:predicate];
    [queryPhotos orderByDescending:@"createdAt"];
    [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@", objects);
            Photo *photo = [objects firstObject];
            PFFile *image = [photo objectForKey:@"image"];
            [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (error) {
                    NSLog(@"Error: %@", error);
                } else {
                    UIImage *image = [UIImage imageWithData:data];
                    cell.photo.image = image;
                }
            }];
        }
    }];
    
    return cell;
}

#pragma mark - Helper Methods

- (void)refreshView {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID = %@", self.userID];
    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Likes parseClassName] predicate:predicate];
    [queryPhotos orderByDescending:@"createdAt"];
    [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.likedPhotos = objects;
            [self.collectionView reloadData];
        }
    }];
}

@end
