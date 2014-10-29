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

@interface PictureRiverViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PictureRiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Picture River";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"UserProfileSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"OtherUserProfileSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"SearchSegue"]) {
        
    } else if ([[segue identifier] isEqual:@"CameraSegue"]) {
        
    }
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.userLabel.text = [NSString stringWithFormat:@"User: %@", @"asher lev"];
    cell.photo.image = [UIImage imageNamed:@"stig"];
    cell.captionLabel.text = @"'Hello World'";
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", @24];
    cell.timeStampLabel.text = [NSString stringWithFormat:@"%@", @"10/31/2014"];
    
    return cell;
}

#pragma mark - IBActions

- (IBAction)unwindUploadViewController:(UIStoryboardSegue *)segue {
    
}

@end
