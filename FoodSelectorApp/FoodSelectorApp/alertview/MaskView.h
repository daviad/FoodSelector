//
//  MaskView.h
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "AlertAnimationView.h"

#define ACTIONVIEW_HEIGHT 60.0f
#define BUTTON_TOP_MARGIN  13.0f
@class MaskView;
@protocol MaskViewDelegate <NSObject>
@optional
- (void)okClick:(id)data withView:(MaskView *)view;
- (void)cancelClick:(id)data;
@end

@interface MaskView : AlertAnimationView<UIGestureRecognizerDelegate>
{
    UIImageView *contentView;
    UIImageView *leftImage;
    UILabel *title;
    UIView *rightTitle;
    UIView *actionView;
    UIButton *confirmbutton;
    UIButton *cancelButton;
    UILabel *contentLabel;
    UIActivityIndicatorView *activityView;

}

@property (nonatomic,assign) id<MaskViewDelegate> delegate;
@property (nonatomic, retain) id dataDic;
- (id)initWithFrame:(CGRect)frame withActionButton:(BOOL)flag;
-(float)LayOutContentView:(UIView *)view;
-(void)LayOutHeadView:(UIView *)view;
- (id)initWithFrame:(CGRect)frame withActionButton:(BOOL)flag withTitle:(NSString *)t withContent:(NSString *)content;
-(void)setTitle:(NSString *)str;
-(void)setContent:(NSString *)str;
-(void)stop;
-(void)setUpRightTitle:(UIView*)view;
-(float)viewWidth;
-(void)setConfirmButton:(NSString *)str;
-(void)setContentBackGround;
-(void)initContentView;
-(void)buttonSend:(id)sender;
@end
