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


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (IBAction)loginPressed:(id)sender {
    
    [[FIRAuth auth] signInWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error signing in: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"Logged in user: %@", user);
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (IBAction)signUpPressed:(id)sender {
    
    [[FIRAuth auth] createUserWithEmail:self.emailTextField.text password:self.passwordTextField.text completion:^(FIRUser * _Nullable user, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error signing up new user: %@", error.localizedDescription);
        }
        
        if (user) {
            NSLog(@"Successfully signed up user: %@", user);
        }
        
    }];
}


@end
