//
//  StuInfoTableViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/21.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "StuInfoTableViewController.h"
#import "WarningBox.h"
#import "XL_wangluo.h"
@interface StuInfoTableViewController ()<UIActionSheetDelegate>
{

    float width;
    float height;
    UIView *backview;
    UIDatePicker *picker;
    NSString*parentRole;//关系
    NSString*studentSex;//性别
    NSString*studentAge;//年龄
}
@end

@implementation StuInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    width =[UIScreen mainScreen].bounds.size.width;
    height=[UIScreen mainScreen].bounds.size.height;
    [self delegate];
    [self xianshi];
    self.title =@"个人信息";
    [self beijing];//日期选择器背景
    [self comeback];
    self.tableView.bounces =NO;
    
    
     //[self setExtraCellLineHidden:self.tableView];
    
    // Uncomment the following line to preserve selection between presentations.
   // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)comeback{
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIBarButtonItem*left=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(fanhui)];
    [self.navigationItem setLeftBarButtonItem:left];
}
-(void)fanhui{
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)delegate{
    _sutname.delegate =self;
    _xingbie.delegate =self;
    _birthday.delegate =self;
    _school.delegate =self;
    _groud.delegate =self;
  
    _parname.delegate =self;
    _phone.delegate =self;
    _shenfen.delegate =self;

}
-(void)xianshi{
    //学生姓名
    if(nil==[_Gerenxinxi objectForKey:@"studentName"]){
     _sutname.text =@"";
    }else{
    _sutname.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentName"]];
    }
    //生日
    if(nil==[_Gerenxinxi objectForKey:@"studentBirtyday"]){
        _birthday.text =@"";
    }else{
     _birthday.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentBirtyday"]];
    }
    //学校
    if(nil==[_Gerenxinxi objectForKey:@"studentSchool"]){
        _school.text =@"";
    }else{
     _school.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentSchool"]];
    }
    //年级
    if(nil==[_Gerenxinxi objectForKey:@"studentGrade"]){
      _groud.text =@"";
    }else{
     _groud.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentGrade"]];
    }
    //家长姓名
    if(nil==[_Gerenxinxi objectForKey:@"parentNick"]){
       _parname.text =@"";
    }else{
      _parname.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"parentNick"]];
    }
    //联系电话
    if(nil==[_Gerenxinxi objectForKey:@"parentTel"]){
       _phone.text =@"";
    }else{
      _phone.text =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"parentTel"]];
    }
    //性别
    if([[_Gerenxinxi objectForKey:@"studentSex"]intValue]==1){
     _xingbie.text =@"男";
    }else if ([[_Gerenxinxi objectForKey:@"studentSex"]intValue]==2) {
     _xingbie.text =@"女";
    }else if ([[_Gerenxinxi objectForKey:@"studentSex"]intValue]==3){
     _xingbie.text =@"保密";
    }else{
    _xingbie.text =@"";
    }
    //家长身份
    if([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==1){
        _shenfen.text =@"母亲";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==2) {
        _shenfen.text =@"父亲";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==3) {
        _shenfen.text =@"爷爷";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==4) {
        _shenfen.text =@"奶奶";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==5) {
        _shenfen.text =@"外公";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==6){
        _shenfen.text =@"外婆";
    }else if ([[_Gerenxinxi objectForKey:@"parentRole"]intValue]==7){
        _shenfen.text =@"其他";
    }else {
     _shenfen.text =@"";
    }
    
    
    
    if(nil==[_Gerenxinxi objectForKey:@"studentAge"]){
    studentAge =@"";
    }else{
    studentAge =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentAge"]];
       
    }
    if(nil==[_Gerenxinxi objectForKey:@"studentSex"]){
       studentSex =@"";
    }else{
    studentSex =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"studentSex"]];
            }
    if(nil==[_Gerenxinxi objectForKey:@"parentRole"]){
        parentRole =@"";
    }else{
    parentRole =[NSString stringWithFormat:@"%@",[_Gerenxinxi objectForKey:@"parentRole"]];
    }
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 2;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    if(section==0){
//        return 6;
//    }else{
//        return 4;
//    }
//}



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Sex:(id)sender {
    [self.view endEditing:YES];
    [_xingbie becomeFirstResponder];
//     _xingbie.inputView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self tan];
}

- (IBAction)Birthday:(id)sender {
    [self.view endEditing:YES];
    [_birthday becomeFirstResponder];
    
}

- (IBAction)Shenfen:(id)sender {
    [self.view endEditing:YES];
    [_shenfen becomeFirstResponder];
//    _shenfen.inputView = [[UIView alloc] initWithFrame:CGRectZero];
//    [self tan1];
}

- (IBAction)Finish:(id)sender {
    [self.view endEditing:YES];
    [self xiugaixinxi];
}


-(void)xiugaixinxi{
    

    
    [WarningBox warningBoxModeIndeterminate:@"正在修改" andView:self.view];
    NSUserDefaults*def =[NSUserDefaults standardUserDefaults];
    NSString *fangshi =@"/userInfo/modifyUserInfoBase";
    NSDictionary *datadic = [NSDictionary dictionaryWithObjectsAndKeys:[def objectForKey:@"studentId"],@"studentId",[def objectForKey:@"officeId"],@"officeId",_sutname.text,@"studentName",_birthday.text,@"studentBirtyday",_school.text,@"studentSchool",_groud.text,@"studentGrade",_parname.text,@"parentNick",_phone.text,@"parentTel",studentSex,@"studentSex",studentAge,@"studentAge",parentRole,@"parentRole", nil];
   
    NSLog(@"-----------311---%@",datadic);
    
    [XL_wangluo JieKouwithBizMethod:fangshi Rucan:datadic type:Post success:^(id responseObject) {
        NSLog(@"成功\n%@",responseObject);
        [WarningBox warningBoxHide:YES andView:self.view];
        
        if ([[responseObject objectForKey:@"code"]isEqual:@"0000"]) {
            [WarningBox warningBoxModeText:@"修改成功" andView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [self.navigationController popViewControllerAnimated:YES];  
            });
            
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
        [WarningBox warningBoxModeText:@"网络连接错误" andView:self.view];
        NSLog(@"失败\n %@",error);
    }];
}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.view endEditing:YES];
//}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
   if(textField==_birthday){
    backview.hidden=NO;
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,width ,44)];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(width - 60, 7,60, 30)];
    [button addTarget:self action:@selector(buttt) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"确定"forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bar addSubview:button];
    textField.inputAccessoryView = bar;
    [self datepicker];
    textField.inputView=picker;
    textField.tintColor=[UIColor clearColor];
    }
    else if(textField==_xingbie){
       _xingbie.inputView = [[UIView alloc] initWithFrame:CGRectZero];
       [self tan];
    }
   else if(textField==_shenfen){
       _shenfen.inputView = [[UIView alloc] initWithFrame:CGRectZero];
       [self tan1];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==_phone){
        [self isMobileNumber:_phone.text];
        if(![self isMobileNumber:_phone.text]){
          [WarningBox warningBoxModeText:@"手机号码有误,请重新输入" andView:self.view];
        }
    }

}
//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if(textField==_sutname){
//        [_xingbie becomeFirstResponder];
//       
//        [self tan];
//    }else if (textField==_xingbie){
//        [_birthday becomeFirstResponder];
//    }else if (textField==_birthday){
//        [_school becomeFirstResponder];
//    }else if (textField==_school){
//        [_groud becomeFirstResponder];
//    }else if (textField==_groud){
//        [_parname becomeFirstResponder];
//    }else if (textField==_parname){
//        [_phone becomeFirstResponder];
//    }else if (textField==_phone){
//        [_shenfen becomeFirstResponder];
//                [self tan1];
//    }else if (textField==_shenfen){
//        [textField resignFirstResponder];
//    }
//    return YES;
//}
#pragma mark--日期选择器
-(void)datepicker{
    picker=[[UIDatePicker alloc] init];
    picker.contentMode=UIViewContentModeCenter;
    picker.datePickerMode=UIDatePickerModeDate;
}
-(void)buttt{
    // 获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [picker date];
    // 创建一个日期格式器
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc] init];
    // 为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    // 使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    NSString *message =[NSString stringWithFormat:@"%@", destDateString];
    _birthday.text =message;
    
    NSDate *nowdate =[NSDate date];
    NSString *sss =[dateFormatter stringFromDate:nowdate];
    sss =[sss substringToIndex:4];
    NSString *cxa =[message substringToIndex:4];
    cxa =[NSString stringWithFormat:@"%d",[sss intValue]-[cxa intValue]+1];
    studentAge =cxa;

  
    [self xiaoshi];
   // [_school becomeFirstResponder];
}
-(void)xiaoshi{
    [self.view endEditing:YES];
    backview.hidden=YES;
}
-(void)beijing{
    //背景
    backview=[[UIView alloc] initWithFrame:CGRectMake(0, 0,width,height)];
    backview.backgroundColor=[UIColor clearColor];
    UITapGestureRecognizer *ss =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xiaoshi)];
    [backview addGestureRecognizer:ss];
    backview.hidden=YES;
    [self.view addSubview:backview];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark--提示框


-(void)tan{
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _xingbie.text=@"男";
        studentSex =@"1";
       
        
       
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _xingbie.text=@"女";
        studentSex =@"2";
       
       
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _xingbie.text=@"保密";
        studentSex =@"3";
      
        
    }]];
    [self.view endEditing:YES];
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)tan1{
   
    UIAlertController *alertControllers = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"母亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"母亲";
        parentRole =@"1";
        
        
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"父亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"父亲";
        parentRole =@"2";
       
        
    }]];
    
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"爷爷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"爷爷";
        parentRole =@"3";
        
        
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"奶奶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"奶奶";
        parentRole =@"4";
       
       
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"外公" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"外公";
        parentRole =@"5";
        
       
    }]];
    
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"外婆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"外婆";
        parentRole =@"6";
        
        
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"其他";
        parentRole =@"7";
        
       
    }]];
    
    [self.view endEditing:YES];
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertControllers animated:YES completion:nil];
}
// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}


@end
