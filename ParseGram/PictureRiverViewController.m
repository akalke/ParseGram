//
//  ViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "PictureRiverViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "OtherUserProfileViewController.h"

@interface PictureRiverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSString *username;
@property NSArray *photos;

@end

@implementation PictureRiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Picture River";
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults stringForKey:@"CURRENT_USER"];
    
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    Photo *selectedPhoto = [self.photos objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    if ([[segue identifier] isEqual:@"UserProfileSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"OtherUserProfileSegue"]) {
        OtherUserProfileViewController *otherUserProfileVC = segue.destinationViewController;
        otherUserProfileVC.user = selectedPhoto.uploadedBy;
    } else if ([[segue identifier] isEqual:@"SearchSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"CameraSegue"]) {
        
    }
}

//- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
//    [super shouldPerformSegueWithIdentifier:@"OtherUserProfileSegue" sender:sender];
//    Photo *selectedPhoto = [self.photos objectAtIndex:self.tableView.indexPathForSelectedRow.row];
//    
//    if ([self.username isEqual:selectedPhoto.uploadedBy]) {
//        [self performSegueWithIdentifier:@"UserProfileSegue" sender:self];
//        return NO;
//    } else {
//        return YES;
//    }
//}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [self.photos objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.userLabel.text = [NSString stringWithFormat:@"%@", photo.uploadedBy];
    
    PFFile *image = [photo objectForKey:@"image"];
    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            UIImage *image = [UIImage imageWithData:data];
            cell.photo.image = image;
        }
    }];
    
    cell.captionLabel.text = [NSString stringWithFormat:@"%@", photo.caption];
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", @24];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSString *date = [format stringForObjectValue:photo.createdAt];
    cell.timeStampLabel.text = [NSString stringWithFormat:@"%@", date];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Photo *selectedPhoto = [self.photos objectAtIndex:indexPath.row];
    if ([self.username isEqual:selectedPhoto.uploadedBy]) {
        [self performSegueWithIdentifier:@"UserProfileSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"OtherUserProfileSegue" sender:self];
    }
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
