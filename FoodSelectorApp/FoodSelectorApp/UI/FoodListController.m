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
#import "AddFoodView.h"

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

-(id)initWithFoodArr:(NSMutableArray*)arr
{
    if(self =[super init])
    {
        self.foodArr = arr;
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"菜单";
    
    CGRect appRect = [[UIScreen mainScreen] applicationFrame];
    foodTB = [[UITableView alloc] initWithFrame:CGRectMake(0, bannerView.frame.size.height, appRect.size.width, appRect.size.height-bannerView.frame.size.height)];
    foodTB.backgroundColor = [UIColor clearColor];
    [self.view addSubview:foodTB];
    foodTB.separatorStyle = UITableViewCellSeparatorStyleNone;
    foodTB.delegate = self;
    foodTB.dataSource = self;
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *rBtn = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStyleBordered target:self action:@selector(addFood)];
    self.navigationItem.rightBarButtonItem = rBtn;

  
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:210.0/255 green:133.0/255 blue:122.0/255 alpha:1]];
   
    
}

-(void)addFood
{
    RCTrace(@"add");
    AddFoodView *addView = [[AddFoodView alloc] initWithFrame:screenFrame withActionButton:YES];
    [self.view addSubview:addView];
    addView.delegate = self;
    [addView show];
}
- (void)okClick:(id)data withView:(MaskView *)maskView
{
    AddFoodView *v =(AddFoodView*) maskView;
    NSString *temStr = v.foodFiled.text;
    if (!temStr  || [[temStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"please " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        DMFood *food = [[DMFood alloc] init];
        food.name = temStr;
        NSDictionary *dic = @{FOOD_NAME: temStr};
        FoodDAO *dao = [[FoodDAO alloc] init];
        [dao save:dic type:0  waitUntilDone:NO];
        
        food.foodId =[NSString  stringWithFormat:@"%d", ((DMFood*)[foodArr lastObject]).foodId.integerValue+1] ;
        [foodArr addObject:food];
        [foodTB reloadData];
    }

}

-(void)deleteFood:(DMFood*)food
{
    if (food.foodId)
    {
        FoodDAO *dao = [[FoodDAO alloc] init];
        [dao deleteByPrimeKey:food.foodId type:0 waitUntilDone:NO];
    }
    
    [foodArr removeObject:food];
    [foodTB reloadData];
}


#pragma mark -table
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return foodArr.count/FoodColumCount + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = indexPath.row;
    static NSString *identifier = @"FoodCell";
    FoodListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[FoodListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
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
