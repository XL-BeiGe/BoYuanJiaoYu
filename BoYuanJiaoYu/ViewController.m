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
    NSUserDefaults *def;
    CGFloat cha;
    int pan;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    def =[NSUserDefaults standardUserDefaults];
    self.title =@"登录";
//    _username.text =@"13845120257";
//    _password.text =@"111111";
    [self registerForKeyboardNotifications];
    [self bianhua];
    //[self huoqujigou];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    _label1.font = [UIFont boldSystemFontOfSize:20];
    _label1.font = [UIFont fontWithName:@"Arial-BoldItalicMT" size:40];
    _label2.font = [UIFont boldSystemFontOfSize:20];
    _label2.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(40.0)];
    
    _label1.shadowColor = [UIColor blackColor];
    _label1.shadowOffset = CGSizeMake(4.0,5.0);
    _label2.shadowColor = [UIColor blackColor];
    _label2.shadowOffset = CGSizeMake(4.0,5.0);
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    
    if(nil==[def objectForKey:@"username"]){
        _username.text =@"";
    }else{
        _username.text =[NSString stringWithFormat:@"%@",[def objectForKey:@"username"]];
    }
    if(nil==[def objectForKey:@"password"]){
        _password.text =@"";
    }else{
        _password.text =[NSString stringWithFormat:@"%@",[def objectForKey:@"password"]];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bianhua{
    
    _forgot.hidden =YES;
    _backview.layer.borderWidth =1;
    _backview.layer.cornerRadius =5;
    _backview.layer.borderColor =[[UIColor colorWithHexString:@"FFDB01"]CGColor];
    _user.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _user.layer.cornerRadius =5;
    _pass.layer.cornerRadius =5;
    use=YES;
    _username.delegate =self;
    _password.delegate =self;
    [_username setClearButtonMode:UITextFieldViewModeWhileEditing];
    
}


- (IBAction)Login:(id)sender {
[self.view endEditing:YES];
//     if(nil==jigouID){
//        [WarningBox warningBoxModeText:@"请选择机构" andView:self.view];
//    }else{
        if(_username.text.length==0){
            [WarningBox warningBoxModeText:@"请输入手机号" andView:self.view];
            
        }else if (_password.text.length==0){
            [WarningBox warningBoxModeText:@"密码或验证码不能为空" andView:self.view];
        }
        else{
            if(![self isMobileNumber:_username.text]){
                [WarningBox warningBoxModeText:@"请检查手机号" andView:self.view];
            }else{
                if(use==YES){
                    [self logined];
                }else{
                    [self quecklogin];
                }
            }
            
        }
  //  }
    
}
//获取机构不用了
-(void)huoqujigou{
    NSString *fangshi =@"/curriculumCenter/officeList";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_username.text,@"tel", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
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
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    for (int index = 0; index <arrr.count; index++) {
        int  key = index;
        NSString*message=[NSString stringWithFormat:@"%@",[arrr[key] objectForKey:@"officeName"]];
        UIAlertAction * action = [UIAlertAction actionWithTitle:message style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //给新家的lable填写信息;
            [[NSUserDefaults standardUserDefaults]setObject:[arrr[key] objectForKey:@"userId"] forKey:@"studentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[arrr[key] objectForKey:@"parentId"] forKey:@"parentId"];
            [[NSUserDefaults standardUserDefaults]setObject:[arrr[key] objectForKey:@"officeId"] forKey:@"officeId"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_username.text] forKey:@"username"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_password.text] forKey:@"password"];
        
            TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
            [self presentViewController:atten animated:YES completion:^{}];
            
            
            
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
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_password.text,@"code",_username.text,@"userName",@"",@"deviceToken", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
            arrr =[NSMutableArray array];
            arrr =[[responseObject objectForKey:@"data"] objectForKey:@"mapList"];
            if(arrr.count==1){
                [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"userId"] forKey:@"studentId"];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"parentId"] forKey:@"parentId"];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"officeId"] forKey:@"officeId"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_username.text] forKey:@"username"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_password.text] forKey:@"password"];
                //
                TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
                [self presentViewController:atten animated:YES completion:^{}];
            }else{
                [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
                [self tan];
            }
            
        }else{
             [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
           
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
       [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];
}
//账号密码登录
-(void)logined{
    [WarningBox warningBoxModeIndeterminate:@"登录中..." andView:self.view];
    NSString *fangshi =@"/index/login";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_password.text,@"passWord",_username.text,@"userName",@"",@"deviceToken",@"1",@"type", nil];
    NSLog(@"%@",datadic);
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
       
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            arrr =[NSMutableArray array];
            arrr =[[responseObject objectForKey:@"data"] objectForKey:@"mapList"];
            if(arrr.count==1){
                [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"userId"] forKey:@"studentId"];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"parentId"] forKey:@"parentId"];
                [[NSUserDefaults standardUserDefaults]setObject:[arrr[0] objectForKey:@"officeId"] forKey:@"officeId"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_username.text] forKey:@"username"];
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",_password.text] forKey:@"password"];
                //
                TabBarViewController *atten = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tabbar"];
                [self presentViewController:atten animated:YES completion:^{}];
            }else{
                [WarningBox warningBoxHide:YES andView:self.view];
              [WarningBox warningBoxModeText:@"登录成功" andView:self.view];
               [self tan];
            }


            
        }else{
              [WarningBox warningBoxHide:YES andView:self.view];
         [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
          
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
         [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];

}

//获取验证码
-(void)SecurityCode{
    [self.view endEditing:YES];
    if(![self isMobileNumber:_username.text]){
        [WarningBox warningBoxModeText:@"请检查手机号" andView:self.view];
    }else{
        NSString *fangshi =@"/index/getAuthCode";
        NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_username.text,@"userName",@"",@"officeId",@"",@"type", nil];
        [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
            NSLog(@"成功\n%@",responseObject);
            
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                [WarningBox warningBoxModeText:@"验证码已发送" andView:self.view];
            }else{
                // [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
            }
            
        } failure:^(NSError *error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
            NSLog(@"失败\n %@",error);
        }];
    }
   
    
    
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
//获取验证码方法
- (IBAction)Forgot:(id)sender {
    //调用获取验证码方法
    [self SecurityCode];
    
}
//用户名密码登录方式
- (IBAction)Users:(id)sender {
    use =YES;
    _user.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _forgot.hidden =YES;
    _password.placeholder =@"请输入密码";
    if(nil==[def objectForKey:@"password"]){
        _password.text =@"";
    }else{
        _password.text =[NSString stringWithFormat:@"%@",[def objectForKey:@"password"]];
    }
    
}
//验证码登录方式
- (IBAction)passs:(id)sender {
    use =NO;
    _user.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
    _pass.backgroundColor =[UIColor colorWithHexString:@"FFDB01"];
    _forgot.hidden =NO;
    _password.placeholder =@"请输入验证码";
    _password.text =@"";
}
- (IBAction)Change:(id)sender {
    //这个已经不用了
    [self huoqujigou];
}

#pragma  mark ---注册通知
- (void) registerForKeyboardNotifications
{
    cha=0.0;
    pan=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(qkeyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(qkeyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark ----通知实现
- (void) qkeyboardWasShown:(NSNotification *) notif
{
    if (pan==0) {
        NSDictionary *info = [notif userInfo];
        NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
        CGSize keyboardSize = [value CGRectValue].size;
        CGRect rect = CGRectMake(_lllll.frame.origin.x, _lllll.frame.origin.y, _lllll.frame.size.width,_lllll.frame.size.height);
        CGFloat kongjian=rect.origin.y+rect.size.height;
        CGFloat viewK=[UIScreen mainScreen].bounds.size.height;
        CGFloat jianpan=keyboardSize.height;
        if (viewK > kongjian+ jianpan) {
            cha=0;
        }else{
            cha=viewK-kongjian-jianpan;
        }
        pan=1;
        [self animateTextField:cha  up: YES];
    }
}
- (void) qkeyboardWasHidden:(NSNotification *) notif
{
    pan=0;
    [self animateTextField:cha up:NO];
}
//视图上移的方法
- (void) animateTextField: (CGFloat) textField up: (BOOL) up
{
    
    //设置视图上移的距离，单位像素
    const int movementDistance = textField; // tweak as needed
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? movementDistance : -movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
    
}

@end
