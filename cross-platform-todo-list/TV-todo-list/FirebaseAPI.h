//
//  FirebaseAPI.h
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TodoItem.h"

typedef void(^AllTodosCompletion)(NSArray<TodoItem *> *allTodos);

@interface FirebaseAPI : NSObject

+ (void)fetchAllTodos:(NSString *)email completion:(AllTodosCompletion)completion;

@end
