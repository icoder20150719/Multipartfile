//
//  ViewController.m
//  ICMultipartFile
//
//  Created by andy  on 15/8/16.
//  Copyright (c) 2015年 andy . All rights reserved.
//

#import "ViewController.h"
#import "MultipartFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建要上传的图片
    UIImage *image = [UIImage imageNamed:@"0180300244.jpg"];
    NSData *data;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    
    //创建MultipartFile
    MultipartFile *file = [[MultipartFile alloc]initWithData:data imageName:@"imageName.png"];
    
    //填写你的URL
    NSString *urlStr = @"your url ";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [file setHTTPReqestInfo:request];
    
    //    NSLog(@"%@",request.HTTPBody);
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data) {
            NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",responseDic);
            
        }else{
            NSLog(@"response:%@\n - NSData:%@ \n-- connectionError:%@",response,data,connectionError);
            
        }
        
    }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
