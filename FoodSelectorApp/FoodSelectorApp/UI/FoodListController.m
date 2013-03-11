//
//  FoodListController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "FoodListController.h"
#import "FoodDAO.h"
#import "DMFood.h"
#import "FoodListCell.h"
@interface FoodListController ()
{
    UITableView *foodTB;
    NSMutableArray *foodArr;
}
@property(nonatomic,strong)NSMutableArray *foodArr;
@end

@implementation FoodListController
@synthesize foodArr;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithFoodArr:(NSArray*)arr
{
    if(self =[super init])
    {
        foodArr = [NSMutableArray array];
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    CGRect appRect = [[UIScreen mainScreen] applicationFrame];
    foodTB = [[UITableView alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height, appRect.size.width, appRect.size.height-bannerView.frame.size.height)];
    foodTB.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:foodTB];
    foodTB.delegate = self;
    foodTB.dataSource = self;
    [self    readDataFromDB];
}


-(void)readDataFromDB
{
    DMFood *f =[[DMFood alloc] init];
    self.foodArr = [f searchAllFood];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return foodArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    static NSString *identifier = @"FoodCell";
    FoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[FoodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:FoodColumCount];
    for (int i= row*FoodColumCount; i<FoodColumCount*row + FoodColumCount; i++)
    {
        if (i>= foodArr.count)
        {
            break;
        }
        [tempArr addObject:[foodArr objectAtIndex:i]];
    }
  
    [cell loadData:[NSArray arrayWithArray:tempArr]];
    return cell;
    
}
@end
