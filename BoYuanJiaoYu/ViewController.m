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
{
    BOOL use;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"登录";
    [self bianhua];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bianhua{
    _reg.layer.borderColor =[[UIColor lightGrayColor]CGColor];
    _reg.layer.borderWidth = 1;
    
    _backview.layer.borderWidth =1;
    _backview.layer.cornerRadius =5;
    _backview.layer.borderColor =[[UIColor orangeColor]CGColor];
    _user.backgroundColor =[UIColor orangeColor];
    _pass.backgroundColor =[UIColor lightGrayColor];
    _user.layer.cornerRadius =5;
    _pass.layer.cornerRadius =5;
    [_forgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
    use=YES;
}


- (IBAction)Login:(id)sender {
    TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
    [self presentViewController:atten animated:YES completion:^{}];
    
    //[self.navigationController pushViewController:atten animated:YES];
    
}

- (IBAction)Regsi:(id)sender {
    NSLog(@"注册页面");
}

- (IBAction)Forgot:(id)sender {
    if(use==YES){
        NSLog(@"跳转忘记密码");
    }else{
    
        NSLog(@"获取验证码");
    }
    
    
}

- (IBAction)Users:(id)sender {
    use =YES;
    _user.backgroundColor =[UIColor orangeColor];
    _pass.backgroundColor =[UIColor lightGrayColor];
    
    [_forgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
}

- (IBAction)passs:(id)sender {
    use =NO;
    _user.backgroundColor =[UIColor lightGrayColor];
    _pass.backgroundColor =[UIColor orangeColor];
    [_forgot setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}
@end
