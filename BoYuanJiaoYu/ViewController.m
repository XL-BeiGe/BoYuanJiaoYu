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
@interface ViewController ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    BOOL use;
    NSMutableArray *arrr;
    NSString *jigouID;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"登录";
    _username.text =@"13845120257";
    _password.text =@"111111";
   // _username.text =@"15005143302";
    //_password.text =@"123456";
    //_username.text =@"13111111111";
    [self bianhua];
    [self huoqujigou];
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
        
        if(use==YES){
            [self logined];
        }else{
            [self quecklogin];
        }

    }
}
//获取机构
-(void)huoqujigou{
    NSString *fangshi =@"/curriculumCenter/officeList";
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:nil type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arrr =[NSMutableArray array];
            arrr =[[responseObject objectForKey:@"data"] objectForKey:@"officeList"];
            if(arrr.count==0){
                NSLog(@"没有机构");
            }else{
                [self tan];
            }
            
            
        }else{
            // [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        
        NSLog(@"失败\n %@",error);
    }];
    

}
-(void)tan{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择机构" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int index = 0; index <arrr.count; index++) {
        int  key = index;
        NSString*message=[NSString stringWithFormat:@"%@",[arrr[key] objectForKey:@"name"]];
        UIAlertAction * action = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"%@",[arrr[key] objectForKey:@"name"]);
            //给新家的lable填写信息;
            jigouID=[NSString stringWithFormat:@"%@",[arrr[key] objectForKey:@"id"]];
            
        }];
        [alert addAction:action];
    }
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

//快速登录
-(void)quecklogin{
    [WarningBox warningBoxModeIndeterminate:@"登录中..." andView:self.view];
    NSString *fangshi =@"/index/quickLogin";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_password.text,@"code",_username.text,@"userName",@"",@"deviceToken",jigouID,@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"userId"] forKey:@"studentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"parentId"] forKey:@"parentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"officeId"] forKey:@"officeId"];
          
           [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
            TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            [self presentViewController:atten animated:YES completion:^{}];
            
        }else{
             [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
           
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
}
//账号密码登录
-(void)logined{
    [WarningBox warningBoxModeIndeterminate:@"登录中..." andView:self.view];
    NSString *fangshi =@"/index/login";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_password.text,@"passWord",_username.text,@"userName",@"",@"deviceToken",@"1",@"type",jigouID,@"officeId", nil];
    NSLog(@"%@",datadic);
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
       
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"userId"] forKey:@"studentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"parentId"] forKey:@"parentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[[responseObject objectForKey:@"data"]objectForKey:@"officeId"] forKey:@"officeId"];
    
            
            TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            [self presentViewController:atten animated:YES completion:^{}];
            
        }else{
              [WarningBox warningBoxHide:YES andView:self.view];
         [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
          
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];

}

//获取验证码
-(void)SecurityCode{
    
    NSString *fangshi =@"/index/getAuthCode";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_username.text,@"userName",jigouID,@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxModeText:@"验证码已发送" andView:self.view];
        }else{
           // [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
    
    
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
    _password.text =@"";
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
