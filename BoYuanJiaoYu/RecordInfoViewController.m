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
    [self comeback];
    // Do any additional setup after loading the view.
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
//错题详情
-(void)cuotixiangqing{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    // NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/errorInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_questionId,@"questionId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxHide:YES andView:self.view];
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];
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
