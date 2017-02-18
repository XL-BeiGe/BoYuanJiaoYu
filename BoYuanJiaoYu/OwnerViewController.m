//
//  OwnerViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/15.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "OwnerViewController.h"

@interface OwnerViewController ()

@end

@implementation OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inviteview.hidden =YES;
    // Do any additional setup after loading the view.
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
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   //_inviteview.hidden =YES;
    [self.view endEditing:YES];
}
- (IBAction)Edit:(id)sender {
}

- (IBAction)Invite:(id)sender {
    _inviteview.hidden =NO;;
}

- (IBAction)Change:(id)sender {
}

- (IBAction)About:(id)sender {
}
- (IBAction)Sure:(id)sender {
    _inviteview.hidden= YES;
}
@end
