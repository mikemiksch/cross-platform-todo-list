//
//  TodoDetailViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TodoDetailViewController.h"

@interface TodoDetailViewController ()

@end

@implementation TodoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.selectedItem.title;
    self.titleLabel.text = self.selectedItem.content;
    
}

- (IBAction)completedPressed:(id)sender {
}


- (IBAction)removePressed:(id)sender {
}


@end
