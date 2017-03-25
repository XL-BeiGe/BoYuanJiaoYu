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
//获取验证码
- (IBAction)secuti:(id)sender {
    [WarningBox warningBoxModeIndeterminate:@"正在发送" andView:self.view];
   NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/index/getAuthCode";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_phone.text,@"userName",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
         [WarningBox warningBoxModeText:@"验证码已发送" andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
         [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"发送失败,请重新发送" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];

    
}
//修改手机号
- (IBAction)Sure:(id)sender {
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
        }else{
       [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];

    
}
@end
