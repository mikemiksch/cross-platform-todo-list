//
//  TVLoginViewController.m
//  cross-platform-todo-list
//
//  Created by Mike Miksch on 5/10/17.
//  Copyright © 2017 Mike Miksch. All rights reserved.
//

#import "TVLoginViewController.h"
#import "TVHomeViewController.h"

@interface TVLoginViewController ()

@end

@implementation TVLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    TVHomeViewController *homeView = [self.storyboard instantiateViewControllerWithIdentifier:@"TVHomeViewController"];
    homeView.email = self.emailTextField.text;
    [self.navigationController pushViewController:homeView animated:YES];
}

@end
