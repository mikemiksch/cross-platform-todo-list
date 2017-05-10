//
//  CompletedViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "CompletedViewController.h"
#import "LoginViewController.h"
#import "TodoItem.h"

@import Firebase;

@interface CompletedViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *completedTableView;

@property (strong, nonatomic) FIRDatabaseReference *userReference;
@property (strong, nonatomic) FIRUser *currentUser;
@property (nonatomic) FIRDatabaseHandle allTodosHandler;
@property (strong, nonatomic) NSMutableArray *allTodos;


@end

@implementation CompletedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.completedTableView.dataSource = self;
    [self setupFirebase];
    [self startMonitoringTodoUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


-(void)setupFirebase {
    FIRDatabaseReference *databaseReference = [[FIRDatabase database]reference];
    self.currentUser = [[FIRAuth auth] currentUser];
    self.userReference = [[databaseReference child:@"users"] child:self.currentUser.uid];
    
    NSLog(@"User reference: %@", self.userReference);
}


-(void)startMonitoringTodoUpdates {
    self.allTodosHandler = [[self.userReference child:@"todos"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        self.allTodos = [[NSMutableArray alloc]init];
        
        for (FIRDataSnapshot *child in snapshot.children) {
            NSDictionary *todoData = child.value;
            NSString *todoTitle = todoData[@"title"];
            NSString *todoContent = todoData[@"content"];
            NSNumber *todoCompleted = todoData[@"completed"];
            
            if (todoCompleted.integerValue == 1) {
                NSLog(@"Looping through completed items");
                TodoItem *currentTodo = [[TodoItem alloc]init];
                currentTodo.title = todoTitle;
                currentTodo.content = todoContent;
                [self.allTodos addObject:currentTodo];
            }
            
        }
        [self.completedTableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allTodos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TodoItem *todo = [self.allTodos objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", todo.title];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", todo.content];
    return cell;
}

@end







