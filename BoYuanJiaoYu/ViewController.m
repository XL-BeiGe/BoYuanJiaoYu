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
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface ViewController ()<UITextFieldDelegate>
{
    BOOL use;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"登录";
    _username.text =@"15545457012";
    _password.text =@"123456";
    [self bianhua];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bianhua{
    
    _forgot.hidden =YES;
    _backview.layer.borderWidth =1;
    _backview.layer.cornerRadius =5;
    _backview.layer.borderColor =[[UIColor colorWithHexString:@"FFBE01"]CGColor];
    _user.backgroundColor =[UIColor colorWithHexString:@"FFBE01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _user.layer.cornerRadius =5;
    _pass.layer.cornerRadius =5;
    use=YES;
    _username.delegate =self;
    _password.delegate =self;
}


- (IBAction)Login:(id)sender {
    if(_username.text.length==0){
        [WarningBox warningBoxModeText:@"请输入手机号" andView:self.view];
    }else if (_password.text.length==0){
        [WarningBox warningBoxModeText:@"密码或验证码不能为空" andView:self.view];
    }
    else{
        NSString *fangshi =@"/index/login";
        NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_password.text,@"passWord",_username.text,@"userName",@"",@"deviceToken",@"1",@"type", nil];
        [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
            NSLog(@"成功\n%@",responseObject);
        } failure:^(NSError *error) {
            NSLog(@"失败\n %@",error);
        }];
        NSLog(@"登录请求 成功跳转");
//        TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
//        [self presentViewController:atten animated:YES completion:^{}];
    }
}



- (IBAction)Forgot:(id)sender {
    
    [self SecurityCode];
    
    
    
    
}

- (IBAction)Users:(id)sender {
    use =YES;
    _user.backgroundColor =[UIColor colorWithHexString:@"FFBE01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _forgot.hidden =YES;
    _password.placeholder =@"请输入密码";
    
}

- (IBAction)passs:(id)sender {
    use =NO;
    _user.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"FFBE01"];
    _forgot.hidden =NO;
    _password.placeholder =@"请输入验证码";
}

//获取验证码
-(void)SecurityCode{
    NSLog(@"获取验证码");
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==_username){
        if(![self isMobileNumber:_username.text]){
            [WarningBox warningBoxModeText:@"手机号输入有误,请重新输入" andView:self.view];
        }
    }
    
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
