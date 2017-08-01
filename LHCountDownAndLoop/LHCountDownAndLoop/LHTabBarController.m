//
//  LHTabBarController.m
//  LHCountDownAndLoop
//
//  Created by liuhuan on 2017/8/1.
//  Copyright © 2017年 zqq. All rights reserved.
//

#import "LHTabBarController.h"
#import "LHHomeViewController.h"
#import "LHClassfiViewController.h"
#import "LHMineViewController.h"

@interface LHTabBarController ()

@end

@implementation LHTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTabBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setCustomTabBar {
    
    [self addChildVc:[LHHomeViewController new] title:@"首页" image:@"tab_home_normal" selectedImage:@"tab_home_select"];
    [self addChildVc:[LHClassfiViewController new] title:@"分类" image:@"tab_infomation_normal" selectedImage:@"tab_infomation_select"];
    [self addChildVc:[LHMineViewController new] title:@"个人中心" image:@"tab_mine_normal" selectedImage:@"tab_mine_select"];
    
    
}
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.title = title;
    childVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    NSDictionary * dict = @{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Light" size:10],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"323232"]};
//    [[UITabBarItem appearance] setTitleTextAttributes:dict forState:UIControlStateNormal];
    
    UINavigationController *navigationVc = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:navigationVc];
}
@end
