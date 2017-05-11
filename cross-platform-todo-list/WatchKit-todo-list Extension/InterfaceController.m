//
//  InterfaceController.m
//  WatchKit-todo-list Extension
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "InterfaceController.h"
#import "TodoRowController.h"



@interface InterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@property (strong, nonatomic) NSArray<TodoItem *> *allTodos;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    [self setupTable];
    // Configure interface objects here.
}

- (void)setupTable {
    [self.table setNumberOfRows:self.allTodos.count withRowType:@"TodoRowController"];
    
    for (NSInteger i = 0; i < self.allTodos.count; i++) {
        TodoRowController *rowController = [self.table rowControllerAtIndex:i];
        
        [rowController.titleLabel setText:self.allTodos[i].title];
        [rowController.contentLabel setText:self.allTodos[i].content];
        
    }
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

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
//    NSDictionary *currentTodoDetails = @{@"title":self.allTodos[rowIndex].title, @"content":self.allTodos[rowIndex].content};
    TodoItem *todo = self.allTodos[rowIndex];
    [self pushControllerWithName:@"TodoDetailInterfaceController" context:todo];
    
}

@end



