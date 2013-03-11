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
   
  
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height, screenFrame.size.width, screenFrame.size.height-50)];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    scrollView.contentSize=CGSizeMake(320, screenFrame.size.height+50);
	// Do any additional setup after loading the view.
    topView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 320, 196)];
    topView.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:topView];
    
    UILabel *descrLB = [[UILabel alloc] initWithFrame:CGRectMake(56, 25, 215, 30)];
    descrLB.text = @"吃什么是关乎生死的大事";
    descrLB.textColor = [UIColor whiteColor];
    descrLB.backgroundColor = [UIColor cyanColor];
    [topView addSubview:descrLB];
    
    UILabel *lineLB = [[UILabel alloc] initWithFrame:CGRectMake(56, 60, 215, 1)];
    lineLB.backgroundColor = [UIColor whiteColor];
    [topView addSubview:lineLB];
    
    resultFoodLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 66, 320, 51)];
    resultFoodLB.textAlignment = NSTextAlignmentCenter;
    resultFoodLB.text = @"xxxxx";
    [topView addSubview:resultFoodLB];
    
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, 320, 40)];
    subTitle.text = @"还想来点啥";
    subTitle.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:subTitle];
    
    UILabel *tipDropLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 168, 320, 15)];
    tipDropLB.textAlignment = NSTextAlignmentCenter;
    tipDropLB.text = @"下拉开始";
    [topView addSubview:tipDropLB];
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height, 320, 47)];
    [menuView setBackgroundColor:[UIColor yellowColor]];
     [scrollView addSubview:menuView];
    
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(43, 5, 100, 20)];
    [menuBtn setBackgroundColor:[UIColor greenColor]];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [menuBtn addTarget:self action:@selector(openMenu) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:menuBtn];
    
    UIButton *settingBtn  = [[UIButton alloc] initWithFrame:CGRectMake(245, 5, 100, 20)];
    [settingBtn setBackgroundColor:[UIColor cyanColor]];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [settingBtn addTarget:self action:@selector(openSetting) forControlEvents:UIControlEventTouchUpInside];
    [menuView addSubview:settingBtn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(menuView.frame), 320, screenFrame.size.height-topView.frame.size.height)];
    [bottomView setBackgroundColor:[UIColor grayColor]];
     [self    readDataFromDB];
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
        int rand =[self getRandomNumber:0 to:foodArr.count];
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
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:c animated:YES];

}

-(void)openSetting
{
    
}
@end
