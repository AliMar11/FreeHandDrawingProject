//
//  WidthViewController.h
//  FreeHandDrawingProject
//
//  Created by Alicia Marisal on 3/28/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WidthViewDelegate <NSObject>

- (void)widthWasChangedTo:(CGFloat)width;

@end


@interface WidthViewController : UIViewController

@property (nonatomic, weak) id <WidthViewDelegate> delegate;



@end
