//
//  ELCModalViewController.h
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 25..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELCModalViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *chosenImages;

- (IBAction)runELC:(id)sender;
- (IBAction)closeELCModalView:(id)sender;
@end
