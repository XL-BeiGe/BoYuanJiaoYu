//
//  NoteListViewController.h
//  BoYuanJiaoYu
//
//  Created by newmac on 2017/2/24.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
