//
//  LoginViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "LoginViewController.h"
@import FirebaseAuth;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UILabel *loginErrorLabel;
@property (weak, nonatomic) IBOutlet UILabel *signupSuccessLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.loginErrorLabel setHidden:YES];
    [self.signupSuccessLabel setHidden:YES];

    
}

- (IBAction)loginPressed:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            [self.signupSuccessLabel setHidden:YES];
            
            if ([error.localizedDescription containsString:@"There is no user record corresponding to this identifier."] || [error.localizedDescription containsString:@"The password is invalid or the user does not have a password."]) {
                
                self.loginErrorLabel.text = @"Invalid login. Please try again, or sign up.";
                [self.loginErrorLabel setHidden:NO];
                
            } else if ([error.localizedDescription containsString:@"The email address is badlyformatted."]) {
                self.loginErrorLabel.text = @"Please enter a valid email address.";
                [self.loginErrorLabel setHidden:NO];
            }
        }
        
        if (user) {
            [self.signupSuccessLabel setHidden:YES];
            [self.loginErrorLabel setHidden:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (IBAction)signUpPressed:(id)sender {
    
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            if ([error.localizedDescription containsString:@"The email address is badly formatted."]) {
                
                self.loginErrorLabel.text = @"Please enter a valid email address.";
                [self.loginErrorLabel setHidden:NO];
            } else if ([error.localizedDescription containsString:@"The password must be 6 characters long or more."]) {
                self.loginErrorLabel.text = @"Passwords must be at least 6 characters in length.";
                [self.loginErrorLabel setHidden:NO];
            }
        
        if (user) {
            [self.loginErrorLabel setHidden:YES];
            
            self.signupSuccessLabel.text = @"Registration successful! Please login.";
            [self.signupSuccessLabel setHidden:NO];
            NSLog(@"Successfully signed up user: %@", user);
            }
        }
        
    }];
}


@end
