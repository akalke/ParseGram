//
//  OtherUserProfileViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "OtherUserProfileViewController.h"
#import "CustomTableViewCell.h"

@interface OtherUserProfileViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OtherUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@", @"the stig"];
    self.photoCountLabel.text = [NSString stringWithFormat:@"Photo Count: %@", @12];
}

#pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.photo.image = [UIImage imageNamed:@"stig"];
    cell.captionLabel.text = @"'Hello World'";
    cell.likesLabel.text = [NSString stringWithFormat:@"Likes: %@", @24];
    cell.timeStampLabel.text = [NSString stringWithFormat:@"%@", @"10/31/2014"];
    
    return cell;
}

@end
