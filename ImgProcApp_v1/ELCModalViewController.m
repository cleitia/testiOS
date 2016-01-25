//
//  ELCModalViewController.m
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 25..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import "ELCModalViewController.h"

@interface ELCModalViewController ()

@end

@implementation ELCModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)runELC:(id)sender {
}

- (IBAction)closeELCModalView:(id)sender {
    [self dismissViewControllerAnimated:NO completion:Nil];
}
@end
