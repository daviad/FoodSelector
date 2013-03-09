//
//  BaseiAdViewController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "BaseiAdViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface BaseiAdViewController ()
{
    NSTimer *_animTimer;
    UIButton *tV;
}
@end

@implementation BaseiAdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ)
{
    CATransform3D transToCenter = CATransform3DMakeTranslation(-center.x, -center.y, 0);
    CATransform3D transBack = CATransform3DMakeTranslation(center.x, center.y, 0);
    CATransform3D scale = CATransform3DIdentity;
    scale.m34 = -1.0f/disZ;
    return CATransform3DConcat(CATransform3DConcat(transToCenter, scale), transBack);
}

CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ)
{
    return CATransform3DConcat(t, CATransform3DMakePerspective(center, disZ));
}
- (void)update
{
//{
//    static float angle = 0;
//    angle += 0.05f;
//    
//    static float x = 0;
//    static float y = 0;
//    static float z = 0;
//    
//    
//    //x=r*sinψcosθ,y=r*sinψsinθ,z=r*cosψ, 其中0≤ψ≤π,0≤θ≤2π。
//    
//    static float zangle = 0;
//    static float otherAngle = 0;
//    
//    static float xAngle = 0;
//    static float yAngle = 0;
//    
//    int r = 100;
//    //x=r*sin(zangle)*cos(otherAngle);
//   // y=r*sin(otherAngle)*cos(zangle);
//   // z=zangle*r;
//    x = r*sin(xAngle);
//    y = r*sin(yAngle);
//    
////    zangle +=0.0001f;
////    otherAngle +=0.0001;
////    if (zangle>M_2_PI)
////    {
////        zangle = 0;
////    }
////    
////    if (otherAngle>2*M_2_PI)
////    {
////        otherAngle = 0;
////    }
//    
////    xAngle += 0.005f;
////    if (xAngle>) {
////        <#statements#>
////    }
//    
//    NSLog(@"x:%f,y:%f,z:%f",x,y,z);
//    
//    
//    CATransform3D transloate = CATransform3DMakeTranslation(x, y, 0);
//  //  CATransform3D rotate = CATransform3DMakeRotation(angle, 0, 1, 0);
//  //  CATransform3D mat = CATransform3DConcat(rotate, transloate);
//   // tV.layer.transform = CATransform3DPerspect(mat, CGPointMake(0, 0), 500);
//    tV.layer.transform = transloate;
}


- (void)stopAnimation
{
    [_animTimer invalidate];
    _animTimer = nil;
}

-(void)startAnimation
{
    if (_animTimer==nil)
    {
        _animTimer = [NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(update) userInfo:nil repeats:YES] ;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
   
	// Do any additional setup after loading the view.
    bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [bannerView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:bannerView];
    
     screenFrame = [[UIScreen mainScreen] applicationFrame];
    
//    
//    tV = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 50, 50)];
//    tV.backgroundColor = [UIColor redColor];
//    [tV addTarget:self action:@selector(doS) forControlEvents:UIControlEventTouchUpInside];
//  //  tV.layer.transform = CATransform3DMakeRotation(M_PI/6, 1, 0, 0);
//
//    [self.view addSubview:tV];
//    [self startAnimation];
    
}

-(void)doS
{
    NSLog(@"good ");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
