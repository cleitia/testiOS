//
//  ELCModalViewControllerDelegate.h
//  ImgProcApp_v1
//
//  Created by ICTWAY on 2016. 1. 25..
//  Copyright © 2016년 ICTWAY. All rights reserved.
//

#import <UIKit/UIkit.h>

@class ELCModalViewController;

@interface ELCModalViewControllerDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet ELCModalViewController *viewController;

@end
