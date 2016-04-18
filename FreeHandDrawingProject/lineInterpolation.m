//
//  lineInterpolation.m
//  FreeHandDrawingProject
//
//  Created by Alicia Marisal on 3/25/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "lineInterpolation.h"

@implementation lineInterpolation

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




//STEP (3) we need to import UIBezierPath UIKit so we can enable the touch(es) and line/curse methods needed in drawing
{
UIBezierPath *path;
//IBOutlet LinearInterpView *xibVC;
}

// STEP(1) override initWithCoder: because the view is a type of 'XIB' thingy...
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        // STEP(2) we want to disable the auto 'muliple touch' property- drawing naturally needs just 1 finger or tool on paper
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        path = [UIBezierPath bezierPath];
        [path setLineWidth:2.0];
    }
    return self;
}

// STEP (5) Set the color/stroke...
- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [path stroke];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path moveToPoint:p];
}

// STEP (4) we need to 'read' user touch movt AND override  the view's auto -drawRect: to enable custome drawing (free-drawing possibilities)...
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint p = [touch locationInView:self];
    [path addLineToPoint:p];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}


@end
