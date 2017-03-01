//
//  XL_wangluo.h
//  BoYuanJiaoYu
//
//  Created by 小狼 on 2017/3/1.
//  Copyright © 2017年 BeiGe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,Post_or_Get) {
    /**
     *  get请求
     */
    Get = 0,
    /**
     *  post请求
     */
    Post
};
@interface XL_wangluo : NSObject
+(void)JieKouwithBizMethod:(NSString*)BizMetho Rucan:(NSDictionary*)BizParamSt type:(Post_or_Get)type success:(void (^)(id responseObject))success
failure:(void (^)(NSError *error))failure;

@end
