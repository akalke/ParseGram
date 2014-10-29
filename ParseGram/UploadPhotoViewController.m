//
//  UploadPhotoViewController.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/28/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "UploadPhotoViewController.h"
#import "Photo.h"
#import "User.h"

@interface UploadPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITextField *captionTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagsTextField;
@property NSString *username;

@end

@implementation UploadPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.username = [userDefaults stringForKey:@"CURRENT_USER"];
}

-(void)viewDidAppear:(BOOL)animated{
    self.imageView.image = self.uploadedImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadPhotoOnPress:(id)sender {

    NSData *data = UIImagePNGRepresentation(self.imageView.image);
    PFFile *imageFile = [PFFile fileWithData:data];

    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(!error){
            Photo *newPhotoObject = [Photo objectWithClassName: @"Photo"];
            [newPhotoObject setObject:imageFile forKey:@"image"];
            newPhotoObject.caption = self.captionTextField.text;
            newPhotoObject.imageTags = self.tagsTextField.text;

            //TODO: REFACTOR GET USER

            newPhotoObject.uploadedBy = self.username;
            [newPhotoObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    NSLog(@"%@", error);
                }
                else{
                    NSLog(@"Image Saved");
                }
            }];
        }
        else{
            NSLog(@"%@", error);
        }
    }];
    //add caption and tags to photo
    //add timestamp, userID
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
