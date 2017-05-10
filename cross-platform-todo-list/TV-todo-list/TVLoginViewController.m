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

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginPressed:(id)sender {
    TVHomeViewController *homeView = [[TVHomeViewController alloc]init];
    homeView.email = self.searchTextField.text;
    [self presentViewController:homeView animated:YES completion:nil];
}

@end
