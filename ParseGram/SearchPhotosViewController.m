//
//  SearchPhotosViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "SearchPhotosViewController.h"
#import "OtherUserProfileViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "User.h"

@interface SearchPhotosViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSArray *searchArray;
@property BOOL searchedUsers;
@property NSString *user;
@property BOOL searchedPoundSigns;
@property NSString *poundSign;

@end

@implementation SearchPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search";
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (self.searchedUsers == YES) {
        User *user = [self.searchArray objectAtIndex:indexPath.row];
        cell.userLabel.text = user.username;
        cell.captionLabel.hidden = YES;
        cell.photo.image = [UIImage imageNamed:@"stig"];
    } else if (self.searchedPoundSigns == YES) {
        Photo *photo = [self.searchArray objectAtIndex:indexPath.row];
        PFFile *image = [photo objectForKey:@"image"];
        [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                UIImage *image = [UIImage imageWithData:data];
                cell.photo.image = image;
            }
        }];
        cell.userLabel.text = photo.uploadedBy;
        cell.captionLabel.text = photo.caption;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherUserProfileViewController *otherUserProfileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"OtherUserProfileVC"];
    if (self.searchedUsers == YES) {
        User *user = [self.searchArray objectAtIndex:indexPath.row];
        otherUserProfileVC.user = user.username;
        [self.navigationController pushViewController:otherUserProfileVC animated:YES];
    } else if (self.searchedPoundSigns == YES) {
        Photo *photo = [self.searchArray objectAtIndex:indexPath.row];
        otherUserProfileVC.user = photo.uploadedBy;
        [self.navigationController pushViewController:otherUserProfileVC animated:YES];
    }
}

#pragma mark - Helper Methods

- (void)refreshView {
    if (self.searchedUsers == YES) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username = %@", self.user];
        PFQuery *queryPhotos = [PFQuery queryWithClassName:[User parseClassName] predicate:predicate];
        [queryPhotos orderByDescending:@"createdAt"];
        [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                self.searchArray = objects;
                [self.tableView reloadData];
            }
        }];
    } else if (self.searchedPoundSigns == YES) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageTags = %@", self.poundSign];
        PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName] predicate:predicate];
        [queryPhotos orderByDescending:@"createdAt"];
        [queryPhotos findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
            } else {
                self.searchArray = objects;
                [self.tableView reloadData];
            }
        }];
    }
}

#pragma mark - IBActions

- (IBAction)onSearchButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search By" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *searchUsers = [UIAlertAction actionWithTitle:@"Users" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.searchedUsers = YES;
        self.searchedPoundSigns = NO;
        self.user = self.searchTextField.text;
        [self refreshView];
        return;
    }];
    UIAlertAction *searchPoundSigns = [UIAlertAction actionWithTitle:@"Pound Signs" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.searchedPoundSigns = YES;
        self.searchedUsers = NO;
        self.poundSign = self.searchTextField.text;
        [self refreshView];
        return;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        return;
    }];
    
    [alert addAction:searchUsers];
    [alert addAction:searchPoundSigns];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
