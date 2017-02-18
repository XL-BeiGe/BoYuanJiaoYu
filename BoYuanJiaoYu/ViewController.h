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
- (IBAction)Login:(id)sender;
- (IBAction)Regsi:(id)sender;
- (IBAction)Forgot:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reg;
@property (weak, nonatomic) IBOutlet UIButton *user;
@property (weak, nonatomic) IBOutlet UIButton *pass;
@property (weak, nonatomic) IBOutlet UIButton *forgot;
@property (weak, nonatomic) IBOutlet UIView *backview;
- (IBAction)Users:(id)sender;
- (IBAction)passs:(id)sender;



@end

