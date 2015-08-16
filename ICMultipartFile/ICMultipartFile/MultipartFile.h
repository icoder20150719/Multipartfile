//
//  MultipartFile.h
//  BestAPP
//
//  Created by andy  on 15/7/24.
//  Copyright (c) 2015年 andy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultipartFile : NSObject
/**文件分割符*/
@property (nonatomic,copy)NSString *boundary;
/**文件类型*/
@property (nonatomic,copy)NSString *Content_Type;
/**post 请求体body的二进制*/
@property (nonatomic,strong)NSData *bodyData;
/**上传的图片二进制*/
@property (nonatomic,strong)NSData *imageData;
/**请求体*/
@property (nonatomic,copy)NSString *body;
/**图片名字*/
@property (nonatomic,copy)NSString *imageName;
/**
 *  boundary 自定义分割符
 *  data     上传的图片二进制
 */
-(instancetype)initWithData:(NSData *)data imageName:(NSString *)imageName;

/**
 *  初始化请求信息
 * 为NSMutableURLRequest 设置请求头 和 请求体
 */
-(void)setHTTPReqestInfo:(NSMutableURLRequest *)request ;

@end
