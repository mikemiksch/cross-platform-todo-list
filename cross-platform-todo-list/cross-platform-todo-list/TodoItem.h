//
//  TodoItem.h
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/8/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodoItem : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
//@property (nonatomic) NSInteger isComplete;

@end
