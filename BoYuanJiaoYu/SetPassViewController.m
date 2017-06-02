//
//  SetPassViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "SetPassViewController.h"
#import "ViewController.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
@interface SetPassViewController ()

@end
@implementation SetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"设置密码";
    [self comeback];
    // Do any additional setup after loading the view.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)Sure:(id)sender {
    if(_password.text.length==0){
    [WarningBox warningBoxModeText:@"请输入密码" andView:self.view];
    }else{
        [self.view endEditing:YES];
        [WarningBox warningBoxModeIndeterminate:@"正在修改" andView:self.view];
        NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
        NSString *fangshi =@"/index/setPassword";
        NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"parentId"],@"userId",_password.text,@"passWord", nil];
        
        
        [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
            NSLog(@"%@",responseObject);
           
            if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
                [WarningBox warningBoxHide:YES andView:self.view];
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
            [WarningBox warningBoxModeText:@"修改失败，请重试" andView:self.view];
            NSLog(@"失败\n %@",error);
        }];
    }
    
  
}
@end
