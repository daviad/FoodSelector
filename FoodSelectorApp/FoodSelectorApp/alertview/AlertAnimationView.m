//
//  BaseAlertView.m
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "AlertAnimationView.h"
#import <QuartzCore/QuartzCore.h>
@implementation AlertAnimationView
typedef void (^AHAnimationCompletionBlock)(BOOL); // Internal.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    if (touch.view.superview)
        if ([touch.view.superview isKindOfClass:[UITableViewCell class]])
            return NO; // ignore the touch
    if([[touch.view class] isSubclassOfClass:[UIButton class]])
        return NO;
    return YES;
}

- (void)performPresentationAnimation
{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
    bounceAnimation.duration = 0.3;
    bounceAnimation.speed = 1;
    bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.01],
                              [NSNumber numberWithFloat:1.1],
                              [NSNumber numberWithFloat:0.9],
                              [NSNumber numberWithFloat:1.0],
                              nil];
    
    [self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
    
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
    fadeInAnimation.duration = 0.3;
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
    [self.superview.layer addAnimation:fadeInAnimation forKey:@"opacity"];
}

- (UIImage *)backgroundGradientImageWithSize:(CGSize)size
{
	CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
	CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
		0.0, 0.0, 0.0, 0.1, // More transparent black
		0.0, 0.0, 0.0, 0.7  // More opaque black
	};
	
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, locationCount);
	
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
	
    return image;
}





- (void)performDismissalAnimation:(PMAlertViewDismissalStyle)dismissalStyle {
	AHAnimationCompletionBlock completionBlock = ^(BOOL finished)
	{
		[self.superview removeFromSuperview];
		[self removeFromSuperview];
	};
	if(dismissalStyle == PMAlertViewDismissalStyleTumble)
	{
		[UIView animateWithDuration:0.5
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^
		 {
			 CGPoint offset = CGPointMake(0, self.superview.bounds.size.height * 1.5);
			 offset = CGPointApplyAffineTransform(offset, self.transform);
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(-M_PI_4));
			 self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(dismissalStyle == PMAlertViewDismissalStyleFade)
	{
		[UIView animateWithDuration:0.25
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^
		 {
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(dismissalStyle == PMAlertViewDismissalStyleZoomDown)
	{
		[UIView animateWithDuration:0.3
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^
		 {
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01));
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(dismissalStyle == PMAlertViewDismissalStyleZoomOut)
	{
		[UIView animateWithDuration:0.2
							  delay:0.0
							options:UIViewAnimationOptionCurveLinear
						 animations:^
		 {
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(10, 10));
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
}






- (void)show
{
	
	[self setNeedsLayout];
	UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
	
	UIImageView *dimView = [[UIImageView alloc] initWithFrame:keyWindow.bounds];
	dimView.image = [self backgroundGradientImageWithSize:keyWindow.bounds.size];
	dimView.userInteractionEnabled = YES;
	
	[keyWindow addSubview:dimView];
	[dimView addSubview:self];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelView:)];
    tap.delegate = self;
    [dimView addGestureRecognizer:tap];
  
	[self performPresentationAnimation];
}

-(void)cancelView:(id)sender
{
    CGPoint dragViewStartPoint = [sender locationInView:alert];
    if(dragViewStartPoint.x > 0 && dragViewStartPoint.y > 0 && dragViewStartPoint.x < alert.frame.size.width && dragViewStartPoint.y < alert.frame.size.height)
        return;
    [self performDismissalAnimation:PMAlertViewDismissalStyleZoomDown];
}


-(void)dismissView
{
    [self performDismissalAnimation:PMAlertViewDismissalStyleZoomDown];
}
-(void)dismissViewAfterDelay
{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self dismissView];
    });;
}


@end
