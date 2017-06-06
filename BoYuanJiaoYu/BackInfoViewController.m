//
//  BackInfoViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/25.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "BackInfoViewController.h"
#import "Color+Hex.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
#import "HongDingYi.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "EBImageBrowser.h"
@interface BackInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float width;
    UILabel *message;
    NSMutableArray *infoarr;
}
@end

@implementation BackInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self delegate];
    [self fankuixiangqing];
    self.title =@"课堂作业";
    [self comeback];
    [self refrish];
   _backimg.hidden =YES;
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
//-(void)navagat{
//    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    UIBarButtonItem*right=[[UIBarButtonItem alloc]initWithTitle:@"反馈历史" style:UIBarButtonItemStyleDone target:self action:@selector(History)];
//    [self.navigationItem setRightBarButtonItem:right];
//}
//
//-(void)History{
//    BackHistoryViewController *his = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"backhis"];
//    [self.navigationController pushViewController:his animated:YES];
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fankuixiangqing{
    [WarningBox warningBoxModeIndeterminate:@"加载中,请稍后..." andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/feedbackInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",_classID,@"classId",@"1",@"pageNo",@"10",@"pageSize",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
      
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
        else if ([[responseObject objectForKey:@"code"]isEqual:@"9999"]){
            //账号在其他手机登录，请重新登录。
            [XL_wangluo sigejiu:self];
        }
        else{
            [WarningBox warningBoxHide:YES andView:self.view];
            [WarningBox warningBoxModeText:[responseObject objectForKey:@"msg"] andView:self.view];
        }
        
    } failure:^(NSError *error) {
        [WarningBox warningBoxHide:YES andView:self.view];
        [WarningBox warningBoxModeText:@"网络连接失败" andView:self.view];

    }];


}
#pragma mark--刷新方法
-(void)refrish{
    //NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [self.table addSubview:refreshControl];
    
}
- (void)refreshClick:(UIRefreshControl *)refreshControl {
    
    [refreshControl beginRefreshing];
    
    // NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
    [self fankuixiangqing];
    [refreshControl endRefreshing];
    //[self.table reloadData];// 刷新tableView即可
}


-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    //self.table.tableFooterView=[[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    width =[UIScreen mainScreen].bounds.size.width;
    //_table.bounces =NO;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return infoarr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return 3;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 30;
    }
    else if(indexPath.row==1){
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
    else{
        return  width/3-15;
    }
    
//    else if (indexPath.row==1){
//        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg1"]){
//            return 0;
//        }else{
//            return 150;
//        }
//    }
//    else if (indexPath.row==2){
//        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg2"]){
//            return 0;
//        }else{
//            return 150;
//        }
//    }else{
//        if(nil==[infoarr[indexPath.section]objectForKey:@"quesionImg3"]){
//            return 0;
//        }else{
//            return 150;
//        }
//    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vv= [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, 5)];
    vv.backgroundColor =[UIColor colorWithHexString:@"EAEEF2"];
   
    return vv;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
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
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 10, width-60, 20)];
        NSString* ss=[[NSString alloc] init];
            if(nil==[infoarr[indexPath.section] objectForKey:@"quesionId"]){
                ss =@"";
            }else{
            ss =[NSString stringWithFormat:@"试题编号:%@",[infoarr[indexPath.section] objectForKey:@"quesionId"]];
            }
        label.text =ss;
        label.textColor =[UIColor  colorWithHexString:@"AAAAAA"];
        [cell addSubview:label];
    }
    
    else if(indexPath.row==1){
        message.numberOfLines =0;
        message.font =[UIFont fontWithName:@"Arial" size:15];
        [cell addSubview:message];
    }
    else{
       
        if(![[infoarr[indexPath.section] objectForKey:@"quesionImg1"]isEqualToString:@""]){
             UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0,width/3-30, width/3-30)];
            //image.contentMode = UIViewContentModeScaleAspectFill;
            //image.contentMode = UIViewContentModeScaleAspectFit;
            img1.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [img1 setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg1"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [img1 sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [img1 addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
                [img1 setUserInteractionEnabled:NO];
            }else{
                [img1 setUserInteractionEnabled:YES];
            }
            [cell addSubview:img1];
        }
        if(![[infoarr[indexPath.section] objectForKey:@"quesionImg2"]isEqualToString:@""]){
              UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(width/3+20,0 , width/3-30, width/3-30)];
            //image.contentMode = UIViewContentModeScaleAspectFill;
            //image.contentMode = UIViewContentModeScaleAspectFit;
            img2.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [img2 setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg2"]];
            
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [img2 sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [img2 addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
            [img2 setUserInteractionEnabled:NO];
            }else{
            [img2 setUserInteractionEnabled:YES];
            }
             [cell addSubview:img2];
        }
        
        
        if(![[infoarr[indexPath.section] objectForKey:@"quesionImg3"]isEqualToString:@""]){
             UIImageView *img3 = [[UIImageView alloc]initWithFrame:CGRectMake((width/3)*2+10, 0, width/3-30, width/3-30)];
            //image.contentMode = UIViewContentModeScaleAspectFill;
            //image.contentMode = UIViewContentModeScaleAspectFit;
            img3.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
            [img3 setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
            NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[infoarr[indexPath.section] objectForKey:@"quesionImg3"]];
            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [img3 sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [img3 addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
                [img3 setUserInteractionEnabled:NO];
            }else{
                [img3 setUserInteractionEnabled:YES];
            }
             [cell addSubview:img3];
        }
        
       
       
    }
   
    
    cell.backgroundColor= [UIColor whiteColor];
    //cell.layer.cornerRadius =5;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)scanBigImageClick1:(UITapGestureRecognizer *)tap{
   
    UIImageView *clickedImageView = (UIImageView *)tap.view;
    //    [XWScanImage scanBigImageWithImageView:clickedImageView];
    [EBImageBrowser showImage:clickedImageView];
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
