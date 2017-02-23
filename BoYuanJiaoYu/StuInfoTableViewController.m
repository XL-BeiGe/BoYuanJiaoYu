//
//  StuInfoTableViewController.m
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/21.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "StuInfoTableViewController.h"

@interface StuInfoTableViewController ()<UIActionSheetDelegate>
{

    float width;
    float height;
    UIView *backview;
    UIDatePicker *picker;
    NSString*parentRole;//关系
    NSString*studentSex;//性别
}
@end

@implementation StuInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
   
    width =[UIScreen mainScreen].bounds.size.width;
    height=[UIScreen mainScreen].bounds.size.height;
    [self delegate];
    [self beijing];//日期选择器背景
     //[self setExtraCellLineHidden:self.tableView];
    
    // Uncomment the following line to preserve selection between presentations.
   // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)delegate{
    _sutname.delegate =self;
    _xingbie.delegate =self;
    _birthday.delegate =self;
    _school.delegate =self;
    _groud.delegate =self;
    _classs.delegate =self;
    _parname.delegate =self;
    _phone.delegate =self;
    _shenfen.delegate =self;

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
    
    [_xingbie becomeFirstResponder];
    
    [self tan];
}

- (IBAction)Birthday:(id)sender {

    [_birthday becomeFirstResponder];
    
}

- (IBAction)Shenfen:(id)sender {
    [_shenfen becomeFirstResponder];
    
    [self tan1];
}

- (IBAction)Finish:(id)sender {
}

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
   if(textField==_xingbie){
       _xingbie.inputView = [[UIView alloc] initWithFrame:CGRectZero];
       [self tan];
    }
   if(textField==_shenfen){
       _shenfen.inputView = [[UIView alloc] initWithFrame:CGRectZero];
       [self tan1];
    }
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==_phone){
        [self isMobileNumber:_phone.text];
        if(![self isMobileNumber:_phone.text]){
            NSLog(@"手机号错误");
        }
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==_sutname){
        [_xingbie becomeFirstResponder];
       
        [self tan];
    }else if (textField==_xingbie){
        [_birthday becomeFirstResponder];
    }else if (textField==_birthday){
        [_school becomeFirstResponder];
    }else if (textField==_school){
        [_groud becomeFirstResponder];
    }else if (textField==_groud){
        [_classs becomeFirstResponder];
    }else if (textField==_classs){
        [_parname becomeFirstResponder];
    }else if (textField==_parname){
        [_phone becomeFirstResponder];
    }else if (textField==_phone){
        [_shenfen becomeFirstResponder];
                [self tan1];
    }else if (textField==_shenfen){
        [textField resignFirstResponder];
    }
    return YES;
}
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
    [self xiaoshi];
    [_school becomeFirstResponder];
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
         [_birthday becomeFirstResponder];
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _xingbie.text=@"女";
        studentSex =@"2";
        [_birthday becomeFirstResponder];
    }]];
    
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _xingbie.text=@"保密";
        studentSex =@"3";
         [_birthday becomeFirstResponder];
    }]];
 
    // 由于它是一个控制器 直接modal出来就好了
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)tan1{
    [_phone resignFirstResponder];
    UIAlertController *alertControllers = [UIAlertController alertControllerWithTitle:@"请选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"点击取消");
        
    }]];
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"母亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"母亲";
        parentRole =@"1";
        [_shenfen resignFirstResponder];
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"父亲" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"父亲";
        parentRole =@"2";
         [_shenfen resignFirstResponder];
    }]];
    
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"爷爷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"爷爷";
        parentRole =@"3";
         [_shenfen resignFirstResponder];
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"奶奶" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"奶奶";
        parentRole =@"4";
         [_shenfen resignFirstResponder];
    }]];
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"外公" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"外公";
        parentRole =@"5";
        [_shenfen resignFirstResponder];
    }]];
    
    
    [alertControllers addAction:[UIAlertAction actionWithTitle:@"外婆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _shenfen.text=@"外婆";
        parentRole =@"6";
         [_shenfen resignFirstResponder];
    }]];
    
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
