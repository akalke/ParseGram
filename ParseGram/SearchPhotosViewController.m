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
@property NSArray *photosArray;

@end

@implementation SearchPhotosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search";
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.photosArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.userLabel.text = [NSString stringWithFormat:@"User: %@", @"asher lev"];
    cell.captionLabel.text = @"'Hello World'";
    cell.photo.image = [UIImage imageNamed:@"stig"];
    
    return cell;
}

#pragma mark - IBActions

- (IBAction)onSearchButtonPressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Search By" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *searchUsers = [UIAlertAction actionWithTitle:@"Users" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        return;
    }];
    UIAlertAction *searchPoundSigns = [UIAlertAction actionWithTitle:@"Pound Signs" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
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
