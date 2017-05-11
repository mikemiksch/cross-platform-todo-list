//
//  TVHomeViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TVHomeViewController.h"
#import "TodoItem.h"
#import "TVTodoDetailViewController.h"
#import "FirebaseAPI.h"

@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvTableView;

@property (strong, nonatomic) NSArray<TodoItem *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tvTableView.dataSource = self;
    self.tvTableView.delegate = self;
    [FirebaseAPI fetchAllTodos:self.email completion:^(NSArray<TodoItem *> *allTodos) {
        NSLog(@"All todos: %@", allTodos);
        self.allTodos = allTodos;
        self.tvTableView.reloadData;

    if (!self.allTodos.count) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"No Results Found!" message:@"Are you sure you entered the correct e-mail?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"Go back" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.allTodos[indexPath.row].title;
    cell.detailTextLabel.text = self.allTodos[indexPath.row].content;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.allTodos count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TVTodoDetailViewController *detailController = [self. storyboard instantiateViewControllerWithIdentifier:@"TVTodoDetaiLViewController"];
    detailController.selectedItem = self.allTodos[indexPath.row];
    [self presentViewController:detailController animated:YES completion:nil];
}

@end
