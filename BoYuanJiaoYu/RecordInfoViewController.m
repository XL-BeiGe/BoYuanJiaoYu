//
//  RecordInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/13.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "RecordInfoViewController.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface RecordInfoViewController ()

@end

@implementation RecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cuotixiangqing];
    // Do any additional setup after loading the view.
}

//错题详情
-(void)cuotixiangqing{
    // NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/errorInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_questionId,@"questionId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"失败\n %@",error);
    }];
    
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

@end
