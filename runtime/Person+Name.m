//
//  Person+Name.m
//  runtime
//
//  Created by Zeke on 2018/4/12.
//  Copyright © 2018年 Zeke. All rights reserved.
//给分类添加属性

#import "Person+Name.h"
#import <objc/runtime.h>

static NSString * nameKey = @"name";

@implementation Person (Name)


-(void)setName:(NSString *)name
{
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name
{
    return objc_getAssociatedObject(self, &nameKey);
}



@end
