//
//  AttentionInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/6/2.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "AttentionInfoViewController.h"
#import "Color+Hex.h"

@interface AttentionInfoViewController ()

@end

@implementation AttentionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self comeback];
    self.title =@"考勤详情";
    

    
    
    if([_Historylist objectForKey:@"className"]==nil){
        _label1.text =@"";
    }else{
        _label1.text =[NSString stringWithFormat:@"%@",[_Historylist objectForKey:@"className"]];
    }
    if([_Historylist objectForKey:@"teacherName"]==nil){
        _label2.text =@"";
    }else{
        _label2.text =[NSString stringWithFormat:@"%@",[_Historylist objectForKey:@"teacherName"]];
    }
    if([_Historylist objectForKey:@"classTimeBegin"]==nil){
        _label3.text =@"";
    }else{
        _label3.text =[NSString stringWithFormat:@"上课时间:%@",[_Historylist objectForKey:@"classTimeBegin"]];
    }
    if([_Historylist objectForKey:@"attendanceTime"]==nil){
        _label4.text =@"";
    }else{
        _label4.text =[NSString stringWithFormat:@"签到时间:%@",[_Historylist objectForKey:@"attendanceTime"]];
    }
    if([_Historylist objectForKey:@"info"]==nil){
        _label5.text =@"";
    }else{
        _label5.text =[NSString stringWithFormat:@"备注:%@",[_Historylist objectForKey:@"info"]];
    }
    
    if([_Historylist objectForKey:@"classType"]==nil){
        [_btuuon setTitle:@"" forState:UIControlStateNormal];
    }else{
        NSString *cias=[NSString stringWithFormat:@"%@",[_Historylist objectForKey:@"classType"]];
        
         [_btuuon setTitle:cias forState:UIControlStateNormal];
    }
    
    NSString *sda =[NSString stringWithFormat:@"%@",[_Historylist objectForKey:@"state"]];
    if([sda intValue]==1){
        _label6.text =@"未签到";
        _label6.textColor =[UIColor colorWithHexString:@"C9D0D6"];
    }else if ([sda intValue]==2){
        _label6.text =@"已签到";
        _label6.textColor =[UIColor colorWithHexString:@"41beff"];
    }else if ([sda intValue]==3){
        _label6.text =@"请假";
        _label6.textColor =[UIColor colorWithHexString:@"EA2121"];
    }else if ([sda intValue]==4){
        _label6.text =@"补课";
        _label6.textColor =[UIColor colorWithHexString:@"41beff"];
        
    }
    
    
    
    
    
    
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

@end
