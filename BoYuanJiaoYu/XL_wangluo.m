//
//  XL_wangluo.m
//  BoYuanJiaoYu
//
//  Created by 小狼 on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import "XL_wangluo.h"
#import "HongDingYi.h"
#import "AFNetworking.h"
#import "SBJsonWriter.h"
@implementation XL_wangluo
+(void)JieKouwithBizMethod:(NSString*)BizMethod Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
                   failure:(void (^)(NSError *error))failure{
    
    NSString *BizMetho=BizMethod;
    NSString *URL =[NSString stringWithFormat:@"%@%@",WaiWang,BizMetho];
    
    NSString *UserID=@"";
    NSString *vaildToken = @"1";
    NSString *accessToken = @"";
    SBJsonWriter *writer=[[SBJsonWriter alloc] init];
    NSDictionary *BizParamStr=BizParamSt;
    NSString *Rucan=[writer stringWithObject:BizParamStr];
    NSDictionary *ChuanCan=[NSDictionary dictionaryWithObjectsAndKeys:Appkey,@"appkey",UserID,@"userid",vaildToken,@"vaildToken",accessToken,@"accessToken",Rucan,@"params", nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/html",nil];
    switch (type) {
        case Get:{
            [manager GET:URL parameters:ChuanCan progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
        case Post:{
            [manager POST:URL parameters:ChuanCan progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (success) {
                    success(responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failure) {
                    failure(error);
                }
            }];
        }
            break;
    }
}
@end
