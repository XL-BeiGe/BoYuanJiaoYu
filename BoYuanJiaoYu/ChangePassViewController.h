//
//  ChangePassViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/6/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *oldpass;
@property (weak, nonatomic) IBOutlet UITextField *newpass;
@property (weak, nonatomic) IBOutlet UITextField *repass;
- (IBAction)Sure:(id)sender;

@end
