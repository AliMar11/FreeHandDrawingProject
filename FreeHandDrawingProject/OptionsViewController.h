//
//  OptionsViewController.h
//  FreeHandDrawingProject
//
//  Created by Alicia Marisal on 3/28/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@protocol OptionsViewController <NSObject>

@end


@interface OptionsViewController : UIViewController
@property (nonatomic, weak) id <OptionsViewController> delegate;

@end
