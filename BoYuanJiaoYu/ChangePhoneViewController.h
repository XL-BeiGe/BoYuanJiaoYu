//
//  ChangePhoneViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePhoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *pass;
- (IBAction)secuti:(id)sender;

- (IBAction)Sure:(id)sender;
@end
