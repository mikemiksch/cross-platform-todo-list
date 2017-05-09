//
//  ViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"
#import "TodoItem.h"
#import "TodoDetailViewController.h"

@import FirebaseAuth;
@import Firebase;

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property(strong, nonatomic) FIRDatabaseReference *userReference;
@property(strong, nonatomic) FIRUser *currentUser;
@property(nonatomic) FIRDatabaseHandle allTodosHandler;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hideUnhideButton;
@property (strong, nonatomic) NSMutableArray *allTodos;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewControllerHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *todoTableView;
@property (weak, nonatomic) IBOutlet UILabel *cellSubtitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewControllerHeightConstraint.constant = 0;
    self.todoTableView.delegate = self;
    self.todoTableView.dataSource = self;

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
        NSLog(@"All Todos: %@", self.allTodos);
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
        
        self.allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            
            NSDictionary *todoData = child.value;
            
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            
            TodoItem *newTodoItem = [[TodoItem alloc] init];
            newTodoItem.title = todoTitle;
            newTodoItem.content = todoContent;
            
            [self.allTodos addObject:newTodoItem];
            [self.todoTableView reloadData];
            
            NSLog(@"Here's the new todo item: %@", newTodoItem);
            
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
    
    if (self.viewControllerHeightConstraint.constant == 0) {
        self.hideUnhideButton.title = @"-";
        self.viewControllerHeightConstraint.constant = 150;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    } else if (self.viewControllerHeightConstraint.constant == 150) {
        self.hideUnhideButton.title = @"+";
        self.viewControllerHeightConstraint.constant = 0;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
        }];
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allTodos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:indexPath];
    TodoItem *item = [self.allTodos objectAtIndex: indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = item.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoDetailViewController *detailController = [[TodoDetailViewController alloc]init];
    TodoItem *selectedItem = self.allTodos[indexPath.row];
    detailController.titleLabel.text = selectedItem.title;
    detailController.contentLabel.text = selectedItem.content;
    [self presentViewController:detailController animated:YES completion:nil];
}


@end
