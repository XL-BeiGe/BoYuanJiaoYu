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



@end

