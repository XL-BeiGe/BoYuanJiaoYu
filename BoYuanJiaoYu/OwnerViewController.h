//
//  OwnerViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *name;

- (IBAction)Edit:(id)sender;
- (IBAction)Invite:(id)sender;
- (IBAction)Change:(id)sender;
- (IBAction)About:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
- (IBAction)Sure:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *inviteview;
- (IBAction)ChangePho:(id)sender;


@end
