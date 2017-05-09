//
//  TodoDetailViewController.h
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodoDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
