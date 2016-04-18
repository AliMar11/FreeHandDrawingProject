//
//  lineInterpolationView.m
//  FreeHandDrawingProject
//
//  Created by Alicia Marisal on 3/25/16.
//  Copyright © 2016 Alicia Marisal. All rights reserved.
//

#import "lineInterpolationView.h"

@implementation lineInterpolationView
{
UIBezierPath *path;
UIImage *incrementalImage;
CGPoint pts[5];
uint ctr;

UIColor *lineColor;
NSUInteger sliderLineWidth;

__weak IBOutlet UISlider *sliderOutlet;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
if (self = [super initWithCoder:aDecoder])
{
    [self setMultipleTouchEnabled:NO];
    [self setBackgroundColor:[UIColor whiteColor]];
    path = [UIBezierPath bezierPath];
    NSUInteger defaultLineWidth = 3.0;
    [path setLineWidth:defaultLineWidth];

}
return self;

}
- (id)initWithFrame:(CGRect)frame
{
self = [super initWithFrame:frame];
if (self) {
    [self setMultipleTouchEnabled:NO];
    path = [UIBezierPath bezierPath];
    NSUInteger defaultLineWidth = 3.0;
    
    //here we set slider position to default
    [path setLineWidth:defaultLineWidth];
}
return self;
}


- (void)drawRect:(CGRect)rect
{
NSLog(@"draw rect");
[incrementalImage drawInRect:rect];
[lineColor setStroke];
[path stroke];


}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
NSLog(@"touches began");

ctr = 0;
UITouch *touch = [touches anyObject];
pts[0] = [touch locationInView:self];
path.lineWidth = sliderLineWidth;

}


//The method below dictates the threshold to initiate a curve.
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
NSLog(@"touches moved equation in use");
UITouch *touch = [touches anyObject];
CGPoint p = [touch locationInView:self];
ctr++;
pts[ctr] = p;
if (ctr == 4)
{
    pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
    
    [path moveToPoint:pts[0]];
    [path addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]];
    
    [self setNeedsDisplay];
    
    pts[0] = pts[3];
    pts[1] = pts[4];
    ctr = 1;
}

}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
NSLog(@"touches ended");
[self drawBitmap];
[self setNeedsDisplay];
[path removeAllPoints];
ctr = 0;
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
[self touchesEnded:touches withEvent:event];
}



- (void)drawBitmap
{
UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0.0);

if (!incrementalImage)
{
    UIBezierPath *rectpath = [UIBezierPath bezierPathWithRect:self.bounds];
    [[UIColor whiteColor] setFill];
    [rectpath fill];
}
[incrementalImage drawAtPoint:CGPointZero];

[lineColor setStroke];
[path stroke];
incrementalImage = UIGraphicsGetImageFromCurrentImageContext();
UIGraphicsEndImageContext();

}


- (IBAction)widthSliderChanged:(UISlider *)sender
{
sliderOutlet.minimumValue = 3.0;
sliderOutlet.maximumValue = 15.0;

sliderLineWidth = sliderOutlet.value;
NSLog(@"WIDTH VALUE: %lu", sliderLineWidth);

}


- (IBAction)clearButton:(UIButton *)sender
{
lineColor = [UIColor whiteColor];
}



- (IBAction)redButtonTapped:(UIButton *)sender
{
lineColor = [UIColor redColor];
}


- (IBAction)orangeButtonTapped:(UIButton *)sender
{
lineColor = [UIColor orangeColor];
}


- (IBAction)yellowButtonTapped:(UIButton *)sender
{
lineColor = [UIColor yellowColor];
}


- (IBAction)greenButtonTapped:(UIButton *)sender
{
lineColor = [UIColor greenColor];
}


- (IBAction)blueButtonTapped:(UIButton *)sender
{
lineColor = [UIColor blueColor];
}


- (IBAction)blackButtonTapped:(UIButton *)sender
{
lineColor = [UIColor blackColor];
}


@end
