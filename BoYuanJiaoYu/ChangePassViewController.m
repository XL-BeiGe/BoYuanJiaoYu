//
//  ChangePassViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/6/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "ChangePassViewController.h"
#import "ViewController.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
@interface ChangePassViewController ()<UITextFieldDelegate>

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"修改密码";
    [self comeback];
    
    
    //textfield 代理
    _oldpass.delegate = self;
    _newpass.delegate = self;
    _repass.delegate = self;
    _newpass.keyboardType = UIKeyboardTypeASCIICapable;
    _oldpass.keyboardType = UIKeyboardTypeASCIICapable;
    _repass.keyboardType=UIKeyboardTypeASCIICapable;
    _oldpass.autocorrectionType = UITextAutocorrectionTypeNo;
    _newpass.autocorrectionType = UITextAutocorrectionTypeNo;
    _repass.autocorrectionType = UITextAutocorrectionTypeNo;
    
    
    
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


#pragma mark - textfield方法

//光标下移
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.oldpass)
    {
        [self.newpass becomeFirstResponder];
    }
    else if (textField == self.newpass)
    {
        [self.repass becomeFirstResponder];
    }
    else
    {
        //结束编辑
        [self.view endEditing:YES];
        [self Sure:nil];
    }
    return YES;
}
#pragma mark - 限制textField位数
-(void)xianzhi
{
    [self.oldpass addTarget:self action:@selector(oldPass) forControlEvents:UIControlEventEditingChanged];
    [self.newpass addTarget:self action:@selector(newPass1) forControlEvents:UIControlEventEditingChanged];
    [self.repass addTarget:self action:@selector(newPass2) forControlEvents:UIControlEventEditingChanged];
}
-(void)oldPass
{
    int MaxLen = 14;
    NSString* szText = [_oldpass text];
    if ([_oldpass.text length]> MaxLen)
    {
        _oldpass.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass1
{
    int MaxLen = 14;
    NSString* szText = [_newpass text];
    if ([_newpass.text length]> MaxLen)
    {
        _newpass.text = [szText substringToIndex:MaxLen];
    }
}
-(void)newPass2
{
    int MaxLen = 14;
    NSString* szText = [_repass text];
    if ([_repass.text length]> MaxLen)
    {
        _repass.text = [szText substringToIndex:MaxLen];
    }
}
#pragma mark - 判断长度
-(BOOL)newpass1:(NSString *)new1
{
    if (self.newpass.text.length < 5) {
        return NO;
    }
    return YES;
}

-(BOOL)newpass_Deng:(NSString *)deng
{
    if (![self.repass.text isEqualToString: self.newpass.text]) {
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)Sure:(id)sender {
    [self.view endEditing:YES];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    
 
    if (self.oldpass.text.length > 0 && self.newpass.text.length > 0 && self.repass.text.length > 0)
    {
        
        if(self.oldpass.text != [NSString stringWithFormat:@"%@",[def objectForKey:@"password"]]){
            [WarningBox warningBoxModeText:@"原密码不正确" andView:self.view];
        }
        else if (![self newpass1:self.newpass.text])
        {
            [WarningBox warningBoxModeText:@"密码长度不够" andView:self.view];
        }
        else if (![self newpass_Deng:self.repass.text])
        {
            [WarningBox warningBoxModeText:@"两次密码不一致，请重新输入" andView:self.view];
        }
        else
        {
            [WarningBox warningBoxModeIndeterminate:@"正在修改" andView:self.view];
    
            NSString *fangshi =@"/index/setPassword";
            NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"parentId"],@"userId",_newpass.text,@"passWord", nil];
            
            
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
            }];        }
    }else{
        [WarningBox warningBoxModeText:@"密码不能为空" andView:self.view];
    }
    
    
    
    
}
@end
