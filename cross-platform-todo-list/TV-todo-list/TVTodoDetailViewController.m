//
//  TVTodoDetailViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/9/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TVTodoDetailViewController.h"

@interface TVTodoDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TVTodoDetailViewController

-(void)loadView {
    [super loadView];
    NSLog(@"You've loaded the detail view controller! %@", self.selectedItem.title);
    self.titleLabel.text = self.selectedItem.title;
    self.contentLabel.text = self.selectedItem.content;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

}



@end
