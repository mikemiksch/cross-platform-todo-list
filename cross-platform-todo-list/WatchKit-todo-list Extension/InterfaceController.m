//
//  InterfaceController.m
//  WatchKit-todo-list Extension
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "InterfaceController.h"
#import "TodoRowController.h"

@import WatchConnectivity;

@interface InterfaceController () <WCSessionDelegate>

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


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [[WCSession defaultSession] setDelegate:self];
//    [[WCSession defaultSession] activateSession];
    
    
    //Message parameter is wehre you want to hand the iOS app new Todo data to save to Firebase
    [[WCSession defaultSession] sendMessage:@{} replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {
        
        NSArray *todoDictionaries = replyMessage[@"todos"];
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *todo in todoDictionaries) {
            NSLog(@"Looping through dictionaries");
            TodoItem *newTodo = [[TodoItem alloc]init];
            newTodo.title = todo[@"title"];
            newTodo.content = todo[@"content"];
            //Assign other values here)
            
            [allTodos addObject:todo];

        }
        
        self.allTodos = allTodos.copy;
        [self setupTable];
        
    } errorHandler:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
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



