//
//  ChangePhoneViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
#import "ViewController.h"
@interface ChangePhoneViewController ()
{
    int timeDown; //60秒后重新获取验证码
    NSTimer *timer;

}
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self comeback];
    self.title =@"更换手机";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//获取验证码
- (IBAction)secuti:(id)sender {
    if(![self isMobileNumber:_phone.text]){
    [WarningBox warningBoxModeText:@"请检查手机号" andView:self.view];
    }else{
        [self.view endEditing:YES];
        [WarningBox warningBoxModeIndeterminate:@"正在发送" andView:self.view];
        NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
        NSString *fangshi =@"/index/getAuthCode";
        NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_phone.text,@"userName",[def objectForKey:@"officeId"],@"officeId",@"1",@"type", nil];
        [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
            NSLog(@"成功\n%@",responseObject);
            [WarningBox warningBoxHide:YES andView:self.view];
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                
                timeDown = 59;
                [self handleTimer];
                timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
                
                [WarningBox warningBoxModeText:@"验证码已发送" andView:self.view];
                
                
            }
            else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
                //账号在其他手机登录，请重新登录。
                [XL_wangluo sigejiu:self];
            }
            else{
                [WarningBox warningBoxHide:YES andView:self.view];
                [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
            }
            
        } failure:^(NSError *error) {
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:@"发送失败,请重新发送" andView:self.view];
            NSLog(@"失败\n %@",error);
        }];
    }
    
   
    
}
-(void)handleTimer
{
    
    if(timeDown>=0)
    {
        [_lslsl setUserInteractionEnabled:NO];
        // [_forgot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        int sec = ((timeDown%(24*3600))%3600)%60;
        [_lslsl setTitle:[NSString stringWithFormat:@"%ds",sec] forState:UIControlStateNormal];
        
    }
    else
    {
        [_lslsl setUserInteractionEnabled:YES];
        // [_forgot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_lslsl setTitle:@"重新发送" forState:UIControlStateNormal];
        
        [timer invalidate];
        
    }
    timeDown = timeDown - 1;
}




//修改手机号
- (IBAction)Sure:(id)sender {
    [self.view endEditing:YES];
    [WarningBox warningBoxModeIndeterminate:@"修改中" andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/index/modifyTel";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"parentId"],@"userId",_phone.text,@"tel",_pass.text,@"code",[def objectForKey:@"officeId"],@"officeId", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
        [WarningBox warningBoxModeText:@"修改成功" andView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                ViewController *view = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"login"];
                [self presentViewController:view animated:YES completion:^{}];
            });
        }
        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
            //账号在其他手机登录，请重新登录。
            [XL_wangluo sigejiu:self];
        }
        else{
       [WarningBox warningBoxHide:YES andView:self.view];
       [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];

    
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
