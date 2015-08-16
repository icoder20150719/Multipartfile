//
//  MultipartFile.m
//  BestAPP
//
//  Created by andy  on 15/7/24.
//  Copyright (c) 2015年 andy . All rights reserved.
//

#import "MultipartFile.h"

@implementation MultipartFile
-(instancetype)init{
    if (self = [super init]) {
          [self setupInfo];
    }
    return self;
}

-(instancetype)initWithData:(NSData *)data imageName:(NSString *)imageName{
    if (self = [super init]) {
        self.imageData = data;
        self.imageName = imageName;
        [self setupInfo];
    }
    return self;
}

-(void)setupInfo{
    
    self.boundary = @"---------------------------8319248739882223";
    self.Content_Type = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",_boundary];
}

-(void)setHTTPReqestInfo:(NSMutableURLRequest *)request
{
    //设置请求体
    [self setHTTPHBodyField:request];
    //设置请求体
    [self setHTTPHeaderField:request];

}
-(void)setHTTPHBodyField:(NSMutableURLRequest *)request{
    //http body
   NSMutableData *bodyData = [NSMutableData data];
    //开头内容
    [bodyData appendData:[[NSString stringWithFormat:@"--%@\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",self.imageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [bodyData appendData:[@"Content-Type:image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //写入图片数据的内容
    [bodyData appendData:self.imageData];
    [bodyData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //写入尾部内容
    [bodyData appendData:[[NSString stringWithFormat:@"--%@--\r\n", self.boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    self.bodyData = bodyData;
    
    [request setHTTPBody:bodyData];
    
}
-(void)setHTTPHeaderField:(NSMutableURLRequest *)request{
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",self.boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%@",@(self.bodyData.length)] forHTTPHeaderField:@"Content-Length"];
    NSLog(@"%@",request.allHTTPHeaderFields);
}

@end
