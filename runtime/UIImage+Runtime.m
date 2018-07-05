//
//  UIImage+Runtime.m
//  runtime
//
//  Created by Zeke on 2018/4/12.
//  Copyright © 2018年 Zeke. All rights reserved.
//

#import "UIImage+Runtime.h"
#import <objc/runtime.h>
#import <objc/message.h>
@implementation UIImage (Runtime)

+(instancetype)imageWithName:(NSString*)name
{
    NSLog(@"------");
    //这里调用imageWithName相当于调用imageName
    UIImage * image = [self imageWithName:name];
    if (image==nil) {
        NSLog(@"加载空的图片");
    }
    
    return image;
}


+(void)load
{
    //获取新方法
    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    
    //获取原方法
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    
    //交换方法
    method_exchangeImplementations(imageName, imageWithName);
}

@end
