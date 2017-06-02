//
//  AttentionInfoViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/6/2.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UIButton *btuuon;



@property (strong ,nonatomic) NSDictionary * Historylist;
@end
