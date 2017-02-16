//
//  ViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ViewController.h"
#import "AttendanceViewController.h"
#import "TabBarViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"登录";
    _reg.layer.borderColor =[[UIColor lightGrayColor]CGColor];
    _reg.layer.borderWidth = 1;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Login:(id)sender {
    TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:atten animated:YES completion:^{}];
    
    //[self.navigationController pushViewController:atten animated:YES];
    
}

- (IBAction)Regsi:(id)sender {
}

- (IBAction)Forgot:(id)sender {
}
@end
