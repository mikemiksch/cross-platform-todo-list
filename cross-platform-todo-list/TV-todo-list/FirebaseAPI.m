//
//  FirebaseAPI.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "FirebaseAPI.h"
#import "Credentials.h"

@implementation FirebaseAPI

+ (void)fetchAllTodos:(NSString *)email completion:(AllTodosCompletion)completion {
    
    NSString *urlString = [NSString stringWithFormat:@"https://todo-list-16ecd.firebaseio.com/users.json?auth=%@", APP_KEY];
    
    NSURL *databaseURL = [NSURL URLWithString:urlString];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration ephemeralSessionConfiguration]];
    
    [[session dataTaskWithURL:databaseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *allTodos = [[NSMutableArray alloc]init];
        
        for (NSDictionary *userTodosDictionary in [rootObject allValues]) {
            NSArray *userTodos = [userTodosDictionary[@"todos"] allValues];
            
            for (NSDictionary *todoDictionary in userTodos) {
                
                if ([email isEqualToString:todoDictionary[@"email"]]) {
                    TodoItem *newTodo = [[TodoItem alloc]init];
                    newTodo.title = todoDictionary[@"title"];
                    newTodo.content = todoDictionary[@"content"];
                //                newTodo.isComplete = todoDictionary[@"isComplete"];
                
                    [allTodos addObject:newTodo];
                }
            }
            
        }
        
        if (completion) {
            
            // This does the same thing as the code below.
            //            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //                completion(allTodos);
            //            }];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(allTodos);
            });
            
        }
        
    }]resume];
}

@end
