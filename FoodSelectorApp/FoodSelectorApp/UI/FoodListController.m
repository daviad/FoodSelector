//
//  FoodListController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "FoodListController.h"

@interface FoodListController ()
{
    UITableView *foodTB;
    NSMutableArray *foodArr;
}

@end

@implementation FoodListController

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
    static NSString *identifier = @"FoodCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [foodArr objectAtIndex:indexPath.row];
    return cell;
    
}
@end
