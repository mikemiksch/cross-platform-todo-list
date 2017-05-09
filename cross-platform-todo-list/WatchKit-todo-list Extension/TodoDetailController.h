//
//  TodoDetailController.h
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <WatchKit/WatchKit.h>
//#import "InterfaceController.h"

@interface TodoDetailController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *titleLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *contentLabel;

@end
