//
//  BaseAlertView.h
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
	PMAlertViewDismissalStyleNone = 0,
	PMAlertViewDismissalStyleZoomDown,
	PMAlertViewDismissalStyleZoomOut,
	PMAlertViewDismissalStyleFade,
	PMAlertViewDismissalStyleTumble
} PMAlertViewDismissalStyle;


@interface AlertAnimationView : UIView<UIGestureRecognizerDelegate>
{
    UIView *alert;
}
-(void)show;
-(void)dismissView;
-(void)dismissViewAfterDelay;
-(void)cancelView:(id)sender;
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
@end
