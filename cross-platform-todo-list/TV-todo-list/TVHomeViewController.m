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

@interface TVHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tvTableView;

@property (strong, nonatomic) NSArray<TodoItem *> *allTodos;

@end

@implementation TVHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tvTableView.dataSource = self;
//    self.tvTableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<TodoItem *> *)allTodos {
    TodoItem *firstTodo = [[TodoItem alloc]init];
    firstTodo.title = @"First Todo";
    firstTodo.content = @"This is a todo item";
    
    TodoItem *secondTodo = [[TodoItem alloc]init];
    secondTodo.title = @"Second Todo";
    secondTodo.content = @"This is a todo item";
    
    TodoItem *thirdTodo = [[TodoItem alloc]init];
    thirdTodo.title = @"Third Todo";
    thirdTodo.content = @"This is a todo item";
    
    return @[firstTodo, secondTodo, thirdTodo];
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
    TVTodoDetailViewController *detailController = [[TVTodoDetailViewController alloc]init];
    detailController.titleLabel.text = self.allTodos[indexPath.row].title;
    detailController.contentLabel.text = self.allTodos[indexPath.row].content;
//    [self presentViewController:detailController animated:YES completion:nil];
}

@end
