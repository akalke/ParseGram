//
//  UserProfileViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "UserProfileViewController.h"
#import "CustomTableViewCell.h"
#import <Parse/Parse.h>

@interface UserProfileViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@", @"asher lev"];
    self.photoCountLabel.text = [NSString stringWithFormat:@"Photo Count: %@", @143];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"LikedPhotosSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"FollowersSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"FollowingSegue"]) {
        
    }
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.photo.image = [UIImage imageNamed:@"stig"];
    cell.captionLabel.text = @"'Hello World'";
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", @24];
    cell.timeStampLabel.text = [NSString stringWithFormat:@"%@", @"10/31/2014"];
    
    return cell;
}

#pragma mark - IBActions

- (IBAction)onLogoutButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"Are you sure?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"Logout" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
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
