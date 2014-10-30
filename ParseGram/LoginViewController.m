//
//  LoginViewController.m
//  ParseGram
//
//  Created by Adam Duflo on 10/27/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PictureRiverViewController.h"
#import "CreateUserViewController.h"
#import "User.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *invalidLoginTextField;
@property BOOL validLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ParseGram";
    self.invalidLoginTextField.text = @"";
}

- (IBAction)loginOnPress:(id)sender {

    PFQuery *loginQuery = [PFQuery queryWithClassName:[User parseClassName]];
    [loginQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(error){
            NSLog(@"%@", error);
        }
        else{
            //TODO: REFACTOR IN LOGIN OBJECT
            for(User *user in objects){
                if([user.username isEqualToString:self.usernameTextField.text] && [user.password isEqualToString:self.passwordTextField.text]){
                    NSLog(@"%@",[user getUserID:user.username]);
                    NSLog(@"USERNAME FOUND");
                    self.validLogin = YES;
                    [self setupUserDefaults:user.username andWithUserID:user.objectId];

                    [self shouldPerformSegueWithIdentifier:@"PhotoStreamSegue" sender:self];
                    break;
                }
                else{
                    self.validLogin = NO;
                }
            }
            if(self.validLogin == NO){
                [self noUserFound];
            }
        }
    }];
}

-(void)setupUserDefaults: (NSString *)username andWithUserID: (NSString *)userID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:@"TRUE" forKey:@"AUTHENTICATED_SESSION"];
    [userDefaults setValue:username forKey:@"CURRENT_USER"];
    [userDefaults setValue:userID forKey:@"CURRENT_USER_ID"];
    [userDefaults synchronize];
    NSString *user = [userDefaults stringForKey:@"CURRENT_USER"];
    NSLog(@"USERNAME: %@", user);
    [self performSegueWithIdentifier:@"PhotoStreamSegue" sender:self];
}

-(void)noUserFound{
    NSLog(@"USERNAME/PASSWORD NOT FOUND");
    self.validLogin = NO;
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
    self.invalidLoginTextField.textColor = [UIColor redColor];
    self.invalidLoginTextField.text = @"Invalid username/password combination";
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    [super shouldPerformSegueWithIdentifier:identifier sender:sender];

    if(self.validLogin == YES && [identifier isEqualToString:@"PhotoStreamSegue"]){
        return YES;
    }
    else if(self.validLogin == NO && [identifier isEqualToString:@"CreateUser"]) {
        NSLog(@"Segue to Create User");
        return YES;
    }
    else{
        return NO;
    }
}


@endgit