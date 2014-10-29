//
//  CreateUserViewController.m
//  ParseGram
//
//  Created by Amaeya Kalke on 10/29/14.
//  Copyright (c) 2014 Adam Duflo. All rights reserved.
//

#import "CreateUserViewController.h"
#import "LoginViewController.h"
#import "User.h"

@interface CreateUserViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@end

@implementation CreateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createUserOnButtonPressed:(id)sender {
        User *newUser = [User objectWithClassName:@"User"];
        newUser.username = self.usernameTextField.text;
        newUser.password = self.passwordTextField.text;
        newUser.emailAddress = self.emailTextField.text;
    
        if(!([self.usernameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]))
        {
            [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if(error){
                    NSLog(@"%@", error);
                }
                else{
                    NSLog(@"SUCCESS! New user created");
                    return;
                }
            }];
        }
        else{
            NSLog(@"Please enter valid user information");
        }

}


-(IBAction)unwindSegueToLogin:(UIStoryboardSegue *)segue{
    LoginViewController *loginVC = segue.destinationViewController;
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
