//
//  SearchPhotosViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "SearchPhotosViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"

@interface SearchPhotosViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSArray *searchArray;
@property BOOL searchedUsers;
@property BOOL searchedPoundSigns;

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
    if (self.searchedPoundSigns == YES) {
        NSLog(@"Pound signs");
    } else if (self.searchedUsers == YES) {
        NSLog(@"Users");
    }
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
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
    cell.userLabel.text = [NSString stringWithFormat:@"%@", photo.uploadedBy];
    cell.captionLabel.text = [NSString stringWithFormat:@"%@", photo.caption];

    return cell;
}

#pragma mark - Helper Methods

- (void)refreshView {
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uploadedBy = %@", self.username];
//    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName] predicate:predicate];
    PFQuery *queryPhotos = [PFQuery queryWithClassName:[Photo parseClassName]];
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

#pragma mark - IBActions

- (IBAction)onSearchButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search By" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *searchUsers = [UIAlertAction actionWithTitle:@"Users" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.searchedUsers = YES;
        [self refreshView];
        return;
    }];
    UIAlertAction *searchPoundSigns = [UIAlertAction actionWithTitle:@"Pound Signs" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.searchedPoundSigns = NO;
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
