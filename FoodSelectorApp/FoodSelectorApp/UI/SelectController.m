//
//  SelectController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-3.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "SelectController.h"
#import "FoodListController.h"
#import "FoodDAO.h"
#import "DMFood.h"
#import <QuartzCore/QuartzCore.h>



@interface SelectController ()
{
    UIScrollView *scrollView;
    UIView* topView;
  
    
    UILabel *resultFoodLB;
    NSTimer *timer ;
    
     NSMutableArray *foodArr;
}

@property(nonatomic,strong)NSMutableArray *foodArr;
@end

@implementation SelectController
@synthesize foodArr;

static int repeatCount = 0;

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
    [self    readDataFromDB];
  
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height, screenFrame.size.width, screenFrame.size.height-50)];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.contentSize=CGSizeMake(320, screenFrame.size.height+50);
	// Do any additional setup after loading the view.
    topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 175)];
    topView.backgroundColor = [UIColor colorWithRed:210.0/255 green:133.0/255 blue:122.0/255 alpha:1];
    [scrollView addSubview:topView];
    
    int h = 15;
    UILabel *descrLB = [[UILabel alloc] initWithFrame:CGRectMake(55, h, 210, 30)];
    descrLB.text = @"吃什么是关乎生死的大事";
    descrLB.textAlignment = NSTextAlignmentCenter;
    descrLB.textColor = [UIColor whiteColor];
    descrLB.backgroundColor = [UIColor clearColor];
    [topView addSubview:descrLB];
    
    h +=30+5;
    UILabel *lineLB = [[UILabel alloc] initWithFrame:CGRectMake(61, h, 200, 1)];
    lineLB.backgroundColor = [UIColor whiteColor];
    [topView addSubview:lineLB];
    
    h += 6;
    resultFoodLB = [[UILabel alloc] initWithFrame:CGRectMake(0, h, 320, 60)];
    resultFoodLB.textAlignment = NSTextAlignmentCenter;
    resultFoodLB.textColor = [UIColor whiteColor];
    resultFoodLB.font = [UIFont systemFontOfSize:44];
    [resultFoodLB setBackgroundColor:[UIColor clearColor]];
    if (self.foodArr.count== 0)
    {
        resultFoodLB.text = @"先添加菜单";
    }
    else
    {
        DMFood *food = [foodArr lastObject];
        resultFoodLB.text = food.name;

    }
    
    [topView addSubview:resultFoodLB];
    
    h +=60-5;
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, h, 320, 40)];
    subTitle.text = @"还想来点啥";
    subTitle.textAlignment = NSTextAlignmentCenter;
    subTitle.textColor = [UIColor whiteColor];
    [subTitle setBackgroundColor:[UIColor clearColor]];

    [topView addSubview:subTitle];
    
    h += 40+2;
    UILabel *tipDropLB = [[UILabel alloc] initWithFrame:CGRectMake(0, h, 320, 15)];
    tipDropLB.textAlignment = NSTextAlignmentCenter;
    tipDropLB.text = @"下拉开始";
    tipDropLB.font = [UIFont systemFontOfSize:14];
    tipDropLB.textColor = [UIColor whiteColor];
    [tipDropLB setBackgroundColor:[UIColor clearColor]];

    [topView addSubview:tipDropLB];
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 47)];
    [menuView setBackgroundColor:[UIColor yellowColor]];
     [scrollView addSubview:menuView];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(43, 15, 50, 20)];
    [menuBtn setBackgroundColor:[UIColor greenColor]];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [menuBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:menuBtn];
    
    UIButton *settingBtn  = [[UIButton alloc] initWithFrame:CGRectMake(230, 15, 50, 20)];
    [settingBtn setBackgroundColor:[UIColor cyanColor]];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [settingBtn addTarget:self action:@selector(openSetting) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:settingBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menuView.frame), 320, screenFrame.size.height-topView.frame.size.height)];
    [bottomView setBackgroundColor:[UIColor grayColor]];
   
   // [self showFoodwithRect:CGRectMake(0, 300, 320, 300)];
}




- (void)scrollViewDidScroll:(UIScrollView *)s
{
    if (s.contentOffset.y<-3)
    {
        RCTrace(@"xia la");
        if (!timer.isValid)
        {
            timer = nil;
            timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(startRun) userInfo:nil repeats:YES];
        }
    
    }
}

-(void)readDataFromDB
{
    DMFood *f =[[DMFood alloc] init];
    self.foodArr = [f searchAllFood];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取一个随机整数，范围在[from,to），包括from，不包括to
-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + arc4random()%(to - from +1));
}

-(void)startRun
{
    RCTrace(@"timer");
    if (foodArr.count>0)
    {
        int rand =[self getRandomNumber:0 to:foodArr.count-1];
        DMFood *food = [foodArr objectAtIndex:rand];
        resultFoodLB.text = food.name;
    }
    if(repeatCount ++  == 9)
    {
        repeatCount = 0;
        [timer invalidate];
    }


    
}
-(void)openMenu
{
    FoodListController   *c = [[FoodListController alloc] initWithFoodArr:foodArr];
//    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    UINavigationItem  *navItem = [[UINavigationItem alloc] int];
//    UIBarButtonItem  *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonSystemItemAdd target:self action:@selector(addFood)];

    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = temporaryBarButtonItem;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:c animated:YES];

}

-(void)openSetting
{
   
}


-(void)showFoodwithRect:(CGRect)crect
{
       
    
    // Configure the particle emitter to the top edge of the screen
	CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
	snowEmitter.emitterPosition = CGPointMake(crect.size.width / 2.0, crect.origin.y);
	snowEmitter.emitterSize		= CGSizeMake(crect.size.width , crect.origin.y);
	
	// Spawn points for the flakes are within on the outline of the line
	snowEmitter.emitterMode		= kCAEmitterLayerOutline;
	snowEmitter.emitterShape	= kCAEmitterLayerLine;
	
	// Configure the snowflake emitter cell
	CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
	
	snowflake.birthRate		= 2.0;
	snowflake.lifetime		= 10.0;
	
	snowflake.velocity		= -10;				// falling down slowly
	snowflake.velocityRange = 10;
	snowflake.yAcceleration = 3;
	snowflake.emissionRange = 0.5 * M_PI;		// some variation in angle
	//snowflake.spinRange		= 0.25 * M_PI;		// slow spin
	
    if (foodArr.count>0)
    {
         
        int rand =[self getRandomNumber:0 to:foodArr.count-1];
        DMFood *food = [foodArr objectAtIndex:rand];
     
    
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        l.textColor = [UIColor whiteColor];
        l.textAlignment = NSTextAlignmentCenter;
        l.text = food.name;
        l.backgroundColor = [UIColor redColor];
        
        UIImage *img = [self renderImageFromView:l];
        snowflake.contents		= (id) [img CGImage];

    }
   
   
    
	//	snowflake.color			= [[UIColor colorWithRed:0.600 green:0.658 blue:0.743 alpha:1.000] CGColor];

    
	// Make the flakes seem inset in the background
	snowEmitter.shadowOpacity = 1.0;
	snowEmitter.shadowRadius  = 0.0;
	snowEmitter.shadowOffset  = CGSizeMake(0.0, 1.0);
	snowEmitter.shadowColor   = [[UIColor whiteColor] CGColor];
	
	// Add everything to our backing layer below the UIContol defined in the storyboard
	snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];
	//[self.window.layer insertSublayer:snowEmitter atIndex:0];
    
    [scrollView.layer addSublayer:snowEmitter];
}

- (UIImage *)renderImageFromView:(UIView *)the_view {
	UIGraphicsBeginImageContextWithOptions(the_view.bounds.size, the_view.opaque, 0.0);
	CGContextRef context=UIGraphicsGetCurrentContext();
	[the_view.layer renderInContext:context];
	//取得影像
	UIImage *the_image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return the_image;
}
@end
