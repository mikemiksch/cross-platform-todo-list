//
//  ViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController ()

@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;

@property(nonatomic) FIRDatabaseHandle allTodosHandler;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hideUnhideButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addTodoTopConstraint;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addTodoTopConstraint.constant = -250;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkUserStatus];

}




- (void)checkUserStatus {
    if (![[FIRAuth auth] currentUser]) {
        LoginViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:loginController animated:YES completion:nil];
    } else {
        [self setupFirebase];
        [self startMonitoringTodoUpdates];
    }
}

- (void)setupFirebase {
    
    FIRDatabaseReference *databaseReference = [[FIRDatabase database] reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"User reference: %@", self.userReference);
    
}

- (void)startMonitoringTodoUpdates {
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            // for lab, append new Todo to allTodos array
            NSLog(@"Todo Title: %@ - Content: %@", todoTitle, todoContent);
            
        }
        
    }];
}

- (IBAction)logOutPressed:(id)sender {
    NSError *signOutError;
    [[FIRAuth auth] signOut:&signOutError];
    [self checkUserStatus];
}


- (IBAction)hideUnhidePressed:(id)sender {
    if (self.addTodoTopConstraint.constant == -250) {
        self.addTodoTopConstraint.constant = 0;
        self.hideUnhideButton.title = @"-";
    } else if (self.addTodoTopConstraint.constant ==0) {
        self.addTodoTopConstraint.constant = -250;
        self.hideUnhideButton.title = @"+";
    }
}


@end
