//
//  TodoDetailInterfaceController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TodoDetailInterfaceController.h"

@interface TodoDetailInterfaceController ()

@end

@implementation TodoDetailInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    self.selectedItem = context;
    NSLog(@"Detail interface controller loaded with this: %@", self.selectedItem.title);
    [self.titleLabel setText:self.selectedItem.title];
    [self.contentLabel setText:self.selectedItem.content];
    
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



