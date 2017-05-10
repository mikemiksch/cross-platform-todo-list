//
//  TodoItem.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TodoItem.h"

@implementation TodoItem

-(instancetype)initWithTitle:(NSString *)title content:(NSString *)content andKey:(NSString *)key {
    self.title = title;
    self.content = content;
    self.key = key;
    self.completed = @0;
    
    return self;
}

@end
