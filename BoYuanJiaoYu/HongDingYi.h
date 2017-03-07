//
//  HongDingYi.h
//  BoYuanJiaoYu
//
//  Created by 小狼 on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#define CLog(format, ...)  NSLog(format, ## __VA_ARGS__)

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define Host    @""
#define Port    @"80"

#define Scheme  @"http://"

//#define WaiwangIP @"192.168.1.110:8080"
#define WaiwangIP @"192.168.1.144:9090"
#define AppName @"/boyuanjiaoyu"
#define apath    @"/api/rest/1.0"
#define WaiWang [NSString stringWithFormat:@"%@%@%@%@",Scheme,WaiwangIP,AppName,apath]

#define Appkey   @"d800528f235e4142b78a8c26c4d537d9"
#define APPSECRET @"d241370da06042be992a4ca21fcac23e"
