//
//  LikedPhotosViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "LikedPhotosViewController.h"
#import "CustomCollectionViewCell.h"

@interface LikedPhotosViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation LikedPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Liked Photos";
}

#pragma mark - CollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.photo.image = [UIImage imageNamed:@"stig"];
    
    return cell;
}

@end
