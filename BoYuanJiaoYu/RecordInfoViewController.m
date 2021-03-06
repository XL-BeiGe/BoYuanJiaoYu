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
#import "EBImageBrowser.h"
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
     NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/learningPortfolio/errorInfo";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:_questionId,@"questionId",[def objectForKey:@"officeId"],@"officeId", nil];
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        
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





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)delegate{
    _table.delegate=self;
    _table.dataSource=self;
    _table.backgroundColor =[UIColor clearColor];
    self.table.tableFooterView=[[UIView alloc] init];
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
        if(![[arr objectForKey:@"quesionImg1"]isEqualToString:@""]){
         return 155;
        }else if(![[arr objectForKey:@"quesionImg2"]isEqualToString:@""]){
          return 155;
        }else if(![[arr objectForKey:@"quesionImg3"]isEqualToString:@""]){
            return 155;
        }else{
         return 0;
        }
       
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
    }
    else if(indexPath.section==1){
    titles.numberOfLines =0;
    titles.font =[UIFont fontWithName:@"Arial" size:15];
    [cell addSubview:titles];
    }
    else if (indexPath.section==2){
        if(![[arr objectForKey:@"quesionImg1"]isEqualToString:@""]){
      UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width-20,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
       // image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg1"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            //为UIImageView1添加点击事件
        UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
        [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
            
            
            
        [cell.contentView addSubview:image];
        }
    }
    else if (indexPath.section==3){
        if(![[arr objectForKey:@"quesionImg2"]isEqualToString:@""]){
        UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width-20,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
        //image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg2"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
        [cell.contentView addSubview:image];
        }
    }
    else{
        if(![[arr objectForKey:@"quesionImg3"]isEqualToString:@""]){
        UIImageView *image =[[UIImageView alloc]init];
        image.frame = CGRectMake(0,0,width-20,150);
        //image.contentMode = UIViewContentModeScaleAspectFill;
        //image.contentMode = UIViewContentModeScaleAspectFit;
        image.clipsToBounds  = YES;//是否剪切掉超出 UIImageView 范围的图片
        [image setContentScaleFactor:[[UIScreen mainScreen] scale]];//缩放图片的分辨率
        NSString *url =[NSString stringWithFormat:@"%@%@%@",Scheme,WaiwangIP,[arr objectForKey:@"quesionImg3"]];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [image sd_setImageWithURL:[NSURL URLWithString:url]  placeholderImage:[UIImage imageNamed:@""]];
            UITapGestureRecognizer *tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scanBigImageClick1:)];
            [image addGestureRecognizer:tapGestureRecognizer1];
            //让UIImageView和它的父类开启用户交互属性
            NSString *ss=[NSString stringWithFormat:@"%@%@(null)",Scheme,WaiwangIP];
            if([url isEqual:ss]){
                [image setUserInteractionEnabled:NO];
            }else{
                [image setUserInteractionEnabled:YES];
            }
        [cell.contentView addSubview:image];
        }
    }

    cell.backgroundColor =[UIColor clearColor];
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
