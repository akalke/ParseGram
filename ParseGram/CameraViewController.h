//
//  CameraViewController.h
//  ParseGram
//
//  Created by Adam Duflo on 10/28/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationBarDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;

- (IBAction)selectPhoto:(id)sender;

@end
