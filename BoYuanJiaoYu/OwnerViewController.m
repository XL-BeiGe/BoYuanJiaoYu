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
#import "ChangePassViewController.h"
#import "StuInfoTableViewController.h"
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
    _inviteview.hidden =YES;
    
    self.title =@"个人中心";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backvie{
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
   //_inviteview.hidden =YES;
    [self.view endEditing:YES];
}
- (IBAction)Edit:(id)sender {
    StuInfoTableViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"stuinfo"];
    [self.navigationController pushViewController:his animated:YES];
    
}

- (IBAction)Invite:(id)sender {
    _inviteview.hidden =NO;
    [self backvie];
    [self.view bringSubviewToFront:_inviteview];
}

- (IBAction)Change:(id)sender {
}

- (IBAction)About:(id)sender {
}
- (IBAction)Sure:(id)sender {
    _inviteview.hidden= YES;
    [self remov];
}
@end
