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
@interface ChangePhoneViewController ()

@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
//获取验证码
- (IBAction)secuti:(id)sender {
   NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/index/getAuthCode";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_phone.text,@"userName",[def objectForKey:@"parentId"],@"userId",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
         [WarningBox warningBoxModeText:@"验证码已发送" andView:self.view];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];

    
}
//修改手机号
- (IBAction)Sure:(id)sender {
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/index/modifyTel";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"parentId"],@"userId",_phone.text,@"tel",_pass.text,@"code",[def objectForKey:@"officeId"],@"officeId", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
        [WarningBox warningBoxModeText:@"修改成功" andView:self.view];
            
        }else{
       [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];

    
}
@end
