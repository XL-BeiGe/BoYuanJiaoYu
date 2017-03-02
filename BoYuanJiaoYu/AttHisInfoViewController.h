//
//  AttHisInfoViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttHisInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backimg;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSString *claassID;
@end
