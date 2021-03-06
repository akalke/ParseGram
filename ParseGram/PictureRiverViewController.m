//
//  ViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "PictureRiverViewController.h"
#import "OtherUserProfileViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "Likes.h"

@interface PictureRiverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *photos;

@end

@implementation PictureRiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Picture River";
    
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Photo *selectedPhoto = [self.photos objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    if ([[segue identifier] isEqual:@"OtherUserProfileSegue"]) {
        OtherUserProfileViewController *otherUserProfileVC = segue.destinationViewController;
        otherUserProfileVC.username = selectedPhoto.uploadedBy;
    }
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.userLabel.text = photo.uploadedBy;
    
    PFFile *image = [photo objectForKey:@"image"];
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            cell.photo.image = image;
        }
    }];
    
    cell.captionLabel.text = photo.caption;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"photoID = %@", photo.objectId];
    PFQuery *queryLikes = [PFQuery queryWithClassName:[Likes parseClassName] predicate:predicate];
    [queryLikes findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %lu", (unsigned long)objects.count];
        }
    }];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSString *date = [format stringForObjectValue:photo.createdAt];
    cell.timeStampLabel.text = date;
    
    return cell;
}

#pragma mark - Helper Methods

- (void)refreshView {
    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName]];
    [queryPhotos orderByDescending:@"createdAt"];
    [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.photos = objects;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - IBActions

- (IBAction)unwindToPictureRiver:(UIStoryboardSegue *)segue {
    
}

@end
