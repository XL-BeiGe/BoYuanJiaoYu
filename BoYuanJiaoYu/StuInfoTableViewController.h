//
//  StuInfoTableViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/21.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StuInfoTableViewController : UITableViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *sutname;
@property (weak, nonatomic) IBOutlet UITextField *xingbie;
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (weak, nonatomic) IBOutlet UITextField *groud;
@property (weak, nonatomic) IBOutlet UITextField *classs;
@property (weak, nonatomic) IBOutlet UITextField *parname;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *shenfen;

- (IBAction)Sex:(id)sender;
- (IBAction)Birthday:(id)sender;
- (IBAction)Shenfen:(id)sender;
- (IBAction)Finish:(id)sender;

@end
