//
//  TVTodoDetailViewController.h
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoItem.h"

@interface TVTodoDetailViewController : UIViewController

@property (strong, nonatomic) TodoItem *selectedItem;

@end
