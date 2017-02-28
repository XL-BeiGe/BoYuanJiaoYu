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
#import "Color+Hex.h"
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
    _backview.layer.borderColor =[[UIColor colorWithHexString:@"ffdb01"]CGColor];
    _user.backgroundColor =[UIColor colorWithHexString:@"ffdb01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"F0EDE8"];
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
    _user.backgroundColor =[UIColor colorWithHexString:@"ffdb01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"F0EDE8"];
    
    [_forgot setTitle:@"忘记密码?" forState:UIControlStateNormal];
    
}

- (IBAction)passs:(id)sender {
    use =NO;
    _user.backgroundColor =[UIColor colorWithHexString:@"F0EDE8"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"ffdb01"];
    [_forgot setTitle:@"获取验证码" forState:UIControlStateNormal];
    
}

// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

@end
