//
//  EditFoodController.m
//  FoodSelectorApp
//
//  Created by dxw on 13-3-2.
//  Copyright (c) 2013年 daviad. All rights reserved.
//

#import "EditFoodController.h"
#import "DMFood.h"
#import "FoodDAO.h"
@interface EditFoodController ()
{
    UITextField *foodNameField;
}
@end

@implementation EditFoodController

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
	// Do any additional setup after loading the view.
    foodNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, 100, 50)];
    foodNameField.backgroundColor = [UIColor redColor];
    [self.view addSubview:foodNameField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)save
{
    NSString *temStr = foodNameField.text;
    if (!temStr  || [[temStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ] isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"please " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
    DMFood *food = [[DMFood alloc] init];
    food.name = temStr;
    NSDictionary *dic = @{FOOD_NAME: @"name1"};
    FoodDAO *dao = [[FoodDAO alloc] init];
    [dao save:dic type:0 waitUntilDone:NO];
    }
}
@end
