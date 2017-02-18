//
//  TabBarViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabBar = self.tabBar;
    
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];

    
   // 创建5个UITabBarItem，然后就开始设置Item的图片了
    
    UIImage *tabBarItem1Image = [UIImage imageNamed:@"kq_y.png"];
    UIImage *imgS1Image =[UIImage imageNamed:@"kq_w.png"];
    tabBarItem1.selectedImage = [tabBarItem1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.image = [imgS1Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabBarItem2Image = [UIImage imageNamed:@"xxda_y.png"];
    UIImage *imgS2Image =[UIImage imageNamed:@"xxda_w.png"];
    tabBarItem2.selectedImage = [tabBarItem2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.image = [imgS2Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabBarItem3Image = [UIImage imageNamed:@"kczx_y.png"];
    UIImage *imgS3Image =[UIImage imageNamed:@"kczx_w.png"];
    tabBarItem3.selectedImage = [tabBarItem3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.image = [imgS3Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *tabBarItem4Image = [UIImage imageNamed:@"grzx_y.png"];
    UIImage *imgS4Image =[UIImage imageNamed:@"grzx_w.png"];
    tabBarItem4.selectedImage = [tabBarItem4Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.image = [imgS4Image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     //tabBar.selectionIndicatorImage = [UIImage imageNamed:@"select_bg"];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                                        } forState:UIControlStateNormal];//未选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor blackColor]
                                                        } forState:UIControlStateSelected];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
