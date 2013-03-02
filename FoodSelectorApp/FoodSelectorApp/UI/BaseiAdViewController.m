//
//  BaseiAdViewController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "BaseiAdViewController.h"

@interface BaseiAdViewController ()
{
    ADBannerView *bannerView;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
   
	// Do any additional setup after loading the view.
    bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    [bannerView setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:bannerView];
    
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
