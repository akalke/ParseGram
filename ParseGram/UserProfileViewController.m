//
//  UserProfileViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "UserProfileViewController.h"
#import "LoginViewController.h"
#import "LikedPhotosViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"

@interface UserProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *userPhotos;
@property NSString *username;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults stringForKey:@"CURRENT_USER"];

    self.title = [NSString stringWithFormat:@"%@", self.username];
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"LikedPhotosSegue"]) {
        LikedPhotosViewController *likedPhotosVC = segue.destinationViewController;
        likedPhotosVC.user = self.username;
    } else if ([[segue identifier] isEqual:@"FollowersSegue"]) {
        // If need to pass properties to followersVC
    } else if ([[segue identifier] isEqual:@"FollowingSegue"]) {
        // If need to pass properties to followingVC
    }
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userPhotos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Photo *photo = [self.userPhotos objectAtIndex:indexPath.row];
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
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

#pragma mark - Helper Methods

- (void)refreshView {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uploadedBy = %@", self.username];
    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName] predicate:predicate];
    [queryPhotos orderByDescending:@"createdAt"];
    [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            self.userPhotos = objects;
            self.photoCountLabel.text = [NSString stringWithFormat:@"Photo Count: %@", @(self.userPhotos.count)];
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - IBActions

- (IBAction)onLogoutButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setValue:@"False" forKey:@"AUTHENTICATED_SESSION"];
        [userDefaults setValue:@"" forKey:@"CURRENT_USER"];
        [userDefaults setValue:@"" forKey:@"CURRENT_USER_ID"];
        [userDefaults synchronize];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateInitialViewController];
        [self presentViewController:loginViewController animated:YES completion:nil];
        return;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        return;
    }];
    
    [alert addAction:logout];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
