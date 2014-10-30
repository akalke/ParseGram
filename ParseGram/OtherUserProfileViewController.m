//
//  OtherUserProfileViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "OtherUserProfileViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>
#import "Photo.h"
#import "Likes.h"

@interface OtherUserProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *userPhotos;

@end

@implementation OtherUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@", self.username];
    
    [self refreshView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshView];
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
    
    cell.captionLabel.text = photo.caption;
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", @24];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd-yyyy"];
    NSString *date = [format stringForObjectValue:photo.createdAt];
    cell.timeStampLabel.text = date;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Like this Photo?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *addLike = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userID = [userDefaults stringForKey:@"CURRENT_USER_ID"];
        
        Photo *selectedPhoto = [self.userPhotos objectAtIndex:indexPath.row];
        NSString *photoID = selectedPhoto.objectId;
        
        Likes *like = [Likes objectWithClassName:[Likes parseClassName]];
        [like logPhotoLike:userID :photoID];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        return;
    }];
    
    [alert addAction:addLike];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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

@end
