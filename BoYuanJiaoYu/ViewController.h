//
//  ViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/14.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)Login:(id)sender;//登录

- (IBAction)Forgot:(id)sender;//验证码

@property (weak, nonatomic) IBOutlet UIButton *user;
@property (weak, nonatomic) IBOutlet UIButton *pass;
@property (weak, nonatomic) IBOutlet UIButton *forgot;
@property (weak, nonatomic) IBOutlet UIView *backview;
- (IBAction)Users:(id)sender;//账号密码登录
- (IBAction)passs:(id)sender;//验证码登录
- (IBAction)Change:(id)sender;



@end

