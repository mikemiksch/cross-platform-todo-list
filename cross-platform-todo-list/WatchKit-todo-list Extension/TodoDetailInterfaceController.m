//
//  TodoDetailInterfaceController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TodoDetailInterfaceController.h"

@interface TodoDetailInterfaceController ()

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;
@property (strong, nonatomic) TodoItem *todo;

@end

@implementation TodoDetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.todo = context;
    NSLog(@"%@", context);
    [self.titleLabel setText:self.todo.title];
    [self.contentLabel setText:self.todo.content];
    
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



