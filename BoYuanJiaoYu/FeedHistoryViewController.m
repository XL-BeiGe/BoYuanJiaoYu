//
//  FeedHistoryViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/5/25.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "FeedHistoryViewController.h"
#import "WarningBox.h"
#import "HongDingYi.h"
#import "XL_wangluo.h"
#import "Color+Hex.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface FeedHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *infoarr;
    float width;
     UILabel *message;
}
@end

@implementation FeedHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self history];
    [self delegate];
    [self comeback];
    _backimg.hidden =YES;
    self.title =@"反馈历史";
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
-(void)history{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/feedbackHistory";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_classID,@"classId",@"1",@"pageNo",@"10",@"pageSize", nil];
    NSLog(@"%@",datadic);
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxHide:YES andView:self.view];
            infoarr =[NSMutableArray array];
            infoarr =[[responseObject objectForKey:@"data"] objectForKey:@"feedbackInfoList"];
            if(infoarr.count==0){
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



-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    _table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return infoarr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        NSString* ss=[[NSString alloc] init];
        if(nil==[infoarr[indexPath.section] objectForKey:@"quesionName"]){
            ss =@"";
        }else{
            ss =[NSString stringWithFormat:@"题目:%@",[infoarr[indexPath.section] objectForKey:@"quesionName"]];
        }
        message=[[UILabel alloc] init];
        UIFont *font = [UIFont fontWithName:@"Arial" size:15];
        NSAttributedString *attributedText =
        [[NSAttributedString alloc]initWithString:ss attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:(CGSize){width-40, CGFLOAT_MAX}
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        
        message.text=ss;
        [message setFrame:CGRectMake(20,10, rect.size.width, rect.size.height)];
        
        return message.frame.size.height+15>40? message.frame.size.height+55:40;
    }
    else if (indexPath.row==1){
        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg1"]){
            return 0;
        }else{
            return 150;
        }
    }
    else if (indexPath.row==1){
        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg2"]){
            return 0;
        }else{
            return 150;
        }
    }else{
        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg3"]){
            return 0;
        }else{
            return 150;
        }
    }
    
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString* ss=[[NSString alloc] init];
    if(nil==[infoarr[section] objectForKey:@"quesionId"]){
        ss =@"";
    }else{
        ss =[NSString stringWithFormat:@"试题编号:%@",[infoarr[section] objectForKey:@"quesionId"]];
    }
    return ss;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *aa=@"heheda";
    UITableViewCell *cell=[self.table cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
    }
    //    for (id suView in cell.contentView.subviews) {//获取当前cell的全部子视图
    //        [suView removeFromSuperview];//移除全部子视图
    //    }
    if(indexPath.row==0){
        message.numberOfLines =0;
        message.font =[UIFont fontWithName:@"Arial" size:15];
        [cell addSubview:message];
    }else if (indexPath.row==1){
        if([infoarr[indexPath.section] objectForKey:@"quesionImg1"]!=nil){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg1"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            //        [self Imageshows];
            [cell.contentView addSubview:image];
        }else{
            
        }
    }
    else if (indexPath.row==2){
        if([infoarr[indexPath.section] objectForKey:@"quesionImg2"]!=nil){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg2"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            //        [self Imageshows];
            [cell.contentView addSubview:image];
        }else{
            
        }
    }
    else{
        if([infoarr[indexPath.section] objectForKey:@"quesionImg3"]!=nil){
            UIImageView *image =[[UIImageView alloc]init];
            image.frame = CGRectMake(0,0,width,150);
            //image.contentMode = UIViewContentModeScaleAspectFill;
            image.contentMode = UIViewContentModeScaleAspectFit;
            image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg3"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            //        [self Imageshows];
            [cell.contentView addSubview:image];
        }
        else{
            
        }
    }
    
    
    
    cell.layer.cornerRadius =5;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
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
