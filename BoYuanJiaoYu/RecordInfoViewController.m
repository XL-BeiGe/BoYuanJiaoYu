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
#import "SDWebImage/UIImageView+WebCache.h"
#import "HongDingYi.h"
@interface RecordInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *arr;
    UILabel *titles;
    float width;
}
@end

@implementation RecordInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"错题详情";
    [self cuotixiangqing];
    [self comeback];
    [self delegate];
    _backimg.hidden=YES;
    width =[UIScreen mainScreen].bounds.size.width;
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
            arr =[responseObject objectForKey:@"data"];
            if(arr.count==0){
                _backimg.hidden =NO;
                _table.hidden =YES;
            }else{
                _table.hidden =NO;
                _backimg.hidden =YES;
            [_table reloadData];
            }
            
            
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
-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return 50;
    }else if (indexPath.section==1){
        NSString* ss=[[NSString alloc] init];
                    if(nil==[arr objectForKey:@"quesionName"]){
                        ss =@"";
                    }else{
                        ss =[NSString stringWithFormat:@"%@",[arr objectForKey:@"quesionName"]];
                    }
        titles=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        titles.text=ss;
        [titles setFrame:CGRectMake(20,10, rect.size.width, rect.size.height)];
        
        return titles.frame.size.height+15>40? titles.frame.size.height+55:40;
    }
    else{
        return 150;
    }

}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"rell";
    UITableViewCell *cell=[self.table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    if(indexPath.section==0){
        UILabel *xixi =[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
        xixi.text =@"作业内容:";
        [cell addSubview:xixi];
    }else if(indexPath.section==1){
    titles.numberOfLines =0;
    titles.font =[UIFont fontWithName:@"Arial" size:15];
    [cell addSubview:titles];
    }else if (indexPath.section==2){
        if([arr objectForKey:@"quesionImg1"]!=nil){
      UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg1"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSLog(@"%@",url);
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
//        [self Imageshows];
        [cell.contentView addSubview:image];
        }
    }else if (indexPath.section==3){
        if([arr objectForKey:@"quesionImg2"]!=nil){
        UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg2"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
        //        [self Imageshows];
        [cell.contentView addSubview:image];
        }
    }else{
        if([arr objectForKey:@"quesionImg3"]!=nil){
        UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg3"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
        //        [self Imageshows];
        [cell.contentView addSubview:image];
        }
    }

    cell.backgroundColor =[UIColor clearColor];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
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
