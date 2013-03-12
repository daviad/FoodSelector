//
//  MaskView.m
//  FoodSelectorApp
//
//  Created by ding xiuwei on 13-3-12.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "MaskView.h"
#import "UIColor+Extends.h"
#define ScreenHeight    [[UIScreen mainScreen] bounds].size.height -20

NSString *const kBtnCyanBgImageName =  @"common_btn_cyan";
NSString *const kBtnOrangeBgImageName = @"common_btn_orange";


@interface MaskView()
{
    float defalutContentHeight;
    UIImageView *headBackGround;
    
}
@property (nonatomic,copy)NSString *contentString;
@end

@implementation MaskView

@synthesize delegate;
@synthesize contentString;

#define BUTTON_WIDTH 105.5f
#define BUTTON_HEIGHT 35.0f


- (id)initWithFrame:(CGRect)frame
{
     self = [self initWithFrame:frame withActionButton:NO];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withActionButton:(BOOL)flag
{
#define DEFAULT_HEIGHT  47.0f
    self = [super initWithFrame:frame];
    if (self)
    {
        alert = [[UIView alloc] init];
        UIImage *headBackGroundImage = [UIImage imageNamed:@"mask_View_Title"];
        headBackGroundImage = [headBackGroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
        headBackGround = [[UIImageView alloc] initWithImage:headBackGroundImage];
        headBackGround.frame = CGRectMake(0, 0, [self viewWidth], headBackGround.frame.size.height);
        
        leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headBackGround.frame.size.height, headBackGround.frame.size.height)];
        [leftImage setContentMode:UIViewContentModeCenter];
        leftImage.backgroundColor = [UIColor clearColor];
        [headBackGround addSubview:leftImage];
    
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(leftImage.frame.origin.x + leftImage.frame.size.width, 0, 350/2, headBackGround.frame.size.height)];
        [headBackGround addSubview:title];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.font = [UIFont boldSystemFontOfSize:16];
       
        
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame = CGRectMake([self viewWidth] - activityView.frame.size.width - 15,
                                        (headBackGround.frame.size.height - activityView.frame.size.height) / 2, activityView.frame.size.width, activityView.frame.size.height);
        [headBackGround addSubview:activityView];
        
        [self setUpRightTitle:headBackGround];
        
        [activityView stopAnimating];
        
        
        
        [alert addSubview:headBackGround];
       
        
        contentView = [[UIImageView alloc] init];
        [self setContentBackGround];
        [self initContentView];
        
        if(flag)
        {
            actionView = [[UIView alloc] init];
//            confirmbutton = [UIButton loochaStdButtonWithFrame:CGRectMake(150, BUTTON_TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)
//                                                         title:NSLocalizedString(@"Ok", )
//                                           backgroundImageName:kBtnOrangeBgImageName];
            UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [self viewWidth], 1)];
            line.backgroundColor = [UIColor hexChangeFloat:@"C6C6C6"];
            [actionView addSubview:line];
           
            
            [actionView addSubview:confirmbutton];
            [confirmbutton addTarget:self action:@selector(buttonSend:) forControlEvents:UIControlEventTouchUpInside];
            
//            cancelButton =[UIButton loochaStdButtonWithFrame:CGRectMake(25, BUTTON_TOP_MARGIN, BUTTON_WIDTH, BUTTON_HEIGHT)
//                                                       title:NSLocalizedString(@"Cancel", )
//                                         backgroundImageName:kBtnCyanBgImageName];
            [actionView addSubview:cancelButton];
            [cancelButton addTarget:self action:@selector(buttonCancel:) forControlEvents:UIControlEventTouchUpInside];
            
            [contentView addSubview:actionView];
          
            actionView.userInteractionEnabled = YES;
            
        }
        [alert addSubview:contentView];
     
        [self addSubview:alert];
      
        
        
        contentView.userInteractionEnabled = YES;
        alert.userInteractionEnabled = YES;
        self.userInteractionEnabled = YES;
    }
    return self;
}



-(void)initContentView
{
    //contentLabel =[[TTLoochaStyledTextLabel alloc] init];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.font = [UIFont systemFontOfSize:15];
    contentLabel.textColor = [UIColor hexChangeFloat:@"393939"];
    contentLabel.textAlignment = UITextAlignmentCenter;
    [contentView addSubview:contentLabel];
 
}

-(void)setContentBackGround
{
    UIImage *contentBackGround = [UIImage imageNamed:@"mask_View_ContentBackground"];
    defalutContentHeight = DEFAULT_HEIGHT;
    contentBackGround = [contentBackGround resizableImageWithCapInsets:UIEdgeInsetsMake(contentBackGround.size.height/2 - 20, 20,contentBackGround.size.height/2 - 20 , 20)];
    [contentView setImage:contentBackGround];
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    float alerth =0;
    alerth += headBackGround.frame.size.height;
    [self LayOutHeadView:headBackGround];
    
    contentView.frame = CGRectMake(headBackGround.frame.origin.x, headBackGround.frame.origin.y + headBackGround.frame.size.height, [self viewWidth],defalutContentHeight);
    float contenth = [self LayOutContentView:contentView];
    
    if(actionView)
    {
        actionView.frame = CGRectMake(0,contenth , [self viewWidth], ACTIONVIEW_HEIGHT);
        contenth += ACTIONVIEW_HEIGHT;
    }
    alerth += contenth;
    contentView.frame = CGRectMake(headBackGround.frame.origin.x, headBackGround.frame.origin.y + headBackGround.frame.size.height, [self viewWidth],contenth );
    CGRect frame = self.frame;
    alert.frame = CGRectMake((frame.size.width - [self viewWidth]) / 2,
                             (ScreenHeight - alerth) / 2, [self viewWidth], alerth);
}

- (id)initWithFrame:(CGRect)frame withActionButton:(BOOL)flag withTitle:(NSString *)t withContent:(NSString *)content
{
    self = [self initWithFrame:frame withActionButton:flag];
    if (self)
    {
        [self setContent:content];
        [self setTitle:t];
    }
    return self;
}

-(void)cancelView:(id)sender
{
    [super cancelView:sender];
}

-(float)LayOutContentView:(UIView *)view
{
    contentLabel.frame =  CGRectMake(10, 0, contentView.frame.size.width - 20, defalutContentHeight);
//    contentLabel.text = [TTStyledText textFromXHTML:contentString lineBreaks:YES URLs:YES];
    [contentLabel sizeToFit];
//    defalutContentHeight = contentLabel.text.height + 20;
    contentLabel.frame =  CGRectMake(10, 10, contentView.frame.size.width - 20, defalutContentHeight - 20);
    return defalutContentHeight;
}

-(void)setConfirmButton:(NSString *)str
{
    [confirmbutton setTitle:str forState:UIControlStateNormal];
}


-(void)LayOutHeadView:(UIView *)view
{
    
}

-(void)setUpRightTitle:(UIView*)view
{
    
}

-(void)buttonSend:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(okClick:withView:)]) {
        [delegate okClick:self.dataDic withView:self];
    }
    [self dismissView];
}


-(void)buttonCancel:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(cancelClick:)]) {
        [delegate cancelClick:self.dataDic];
    }
    [self dismissView];
}

-(void)setTitle:(NSString *)str
{
    title.text = str;
}

-(void)setContent:(NSString *)str
{
    if([str rangeOfString:@"<span>"].location == NSNotFound)
        str  = [NSString stringWithFormat:@"<span class=\"DefaultTitle\">%@</span>",str];
    self.contentString = str;
    [self setNeedsLayout];
}

-(void)stop
{
    [activityView stopAnimating];
}

-(float)viewWidth
{
    return headBackGround.frame.size.width;
}



@end
