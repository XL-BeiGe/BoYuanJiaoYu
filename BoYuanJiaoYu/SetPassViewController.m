//
//  SetPassViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "SetPassViewController.h"
#import "XL_wangluo.h"
#import "WarningBox.h"
@interface SetPassViewController ()

@end

@implementation SetPassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (IBAction)Sure:(id)sender {
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/index/setPassword";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_password.text,@"password", nil];
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
}
@end
