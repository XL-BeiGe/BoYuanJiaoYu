//
//  OwnerViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "OwnerViewController.h"
#import "Color+Hex.h"
#import "ExplainViewController.h"
//#import "ChangePassViewController.h"
#import "StuInfoTableViewController.h"
#import "WarningBox.h"
#import "SetPassViewController.h"
#import "ChangePhoneViewController.h"
#import "NoteListViewController.h"
#import "XL_wangluo.h"
@interface OwnerViewController ()<UITextFieldDelegate>
{
    float width;
    float height;
    UIView *vv;
}
@end

@implementation OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navagat];
    [self gerenxinxi];
    _inviteview.hidden =YES;
    _phoneNum.delegate =self;
    self.title =@"个人中心";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navagat{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"通知" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
    [self.navigationItem setRightBarButtonItem:right];
}

-(void)History{
    NoteListViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"notelist"];
    [self.navigationController pushViewController:his animated:YES];
}
-(void)backview{
    width =[UIScreen mainScreen].bounds.size.width;
    height =[UIScreen mainScreen].bounds.size.height;
    
    _inviteview.layer.cornerRadius =10;
    
    vv =[[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    vv.backgroundColor =[UIColor blackColor];
    vv.alpha =0.7;
    [self.view addSubview:vv];
}
-(void)remov{
    [vv removeFromSuperview];
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
//   _inviteview.hidden =YES;
//    [self remov];
    [self.view endEditing:YES];
}
//修改个人信息
- (IBAction)Edit:(id)sender {
    StuInfoTableViewController *stuinfo = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"stuinfo"];
    [self.navigationController pushViewController:stuinfo animated:YES];
    
}
//邀请家人
- (IBAction)Invite:(id)sender {
    _inviteview.hidden =NO;
    [self backview];
    [self.view bringSubviewToFront:_inviteview];
}
//修改密码
- (IBAction)Change:(id)sender {
    SetPassViewController *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"setpass"];
    [self.navigationController pushViewController:set animated:YES];
}
//关于我们
- (IBAction)About:(id)sender {
    ExplainViewController *explain = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"explain"];
    [self.navigationController pushViewController:explain animated:YES];
}
- (IBAction)ChangePho:(id)sender {
    ChangePhoneViewController *change = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"changephone"];
    [self.navigationController pushViewController:change animated:YES];
}
- (IBAction)Sure:(id)sender {
    _inviteview.hidden= YES;
    [_phoneNum resignFirstResponder];
    [self inviteparents];
}
//邀请家人接口
-(void)inviteparents{
    
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/userInfo/userInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",@"1111",@"parentId",_phoneNum.text,@"tel", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
           [self remov];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
 
    
   
}

//获取个人信息
-(void)gerenxinxi{
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/userInfo/getUserInfoBase";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            _stuname.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"studentName"]];
            _stuclass.text =[NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"studentGrade"]];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
}




-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==_phoneNum){
        if(![self isMobileNumber:_phoneNum.text]){
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
