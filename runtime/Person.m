//
//  Person.m
//  runtime
//
//  Created by Zeke on 2018/4/12.
//  Copyright © 2018年 Zeke. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person()
{
    NSString * _str;
    NSNumber * _list;
    NSArray * _array;
}


@property(nonatomic,copy)NSString * personName,*personSex,*personHobby;
@property(nonatomic,assign)int  personAge;

@end


@implementation Person
-(void)eat
{
    NSLog(@"eat-------");
}
+(void)Play
{
    NSLog(@"Play-------");
}

//+(BOOL)resolveClassMethod:(SEL)sel
//{
//   
//}

//！！！！class_addMethod 第四个参数，参考网址：https://blog.csdn.net/lgqyhm2010/article/details/14128611


+(BOOL)resolveInstanceMethod:(SEL)sel
{
    //(IMP)addNewMethod意思是addNewMethod的地址指针
    if (sel == @selector(addNewMethod)) {
        class_addMethod(self, sel, (IMP)addNewMethod, "v@:");
        return YES;
    }
    if (sel == @selector(addNum:)) {
        class_addMethod(self, sel, (IMP)addNum, "i@:@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

//id self,SEL sel  这2个参数是必传参数，如果还要添加，就在参数后面继续进行添加
void addNewMethod(id self,SEL sel)
{
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}

int addNum(id self,SEL sel,id num)
{
//    num++;
    NSLog(@"%@",num);
    return [num intValue];
}

/**
 获取属性列表
 */
-(void)PropertyNum
{
    unsigned int count;
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i =0; i<count; i++) {
        const char * propertyName = property_getName(propertyList[i]);
        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
    }
    NSLog(@"---------------------");
}
/**
 获取方法列表
 */
-(void)MethodListNum
{
    unsigned int count;
    Method * methodList = class_copyMethodList([self class], &count);
    for (unsigned int i =0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"%@",NSStringFromSelector(method_getName(method)));
    }
    NSLog(@"---------------------");
}
/**
 获取成员变量列表
 */
-(void)IVarListNum
{
    unsigned int count;
    Ivar * ivarList = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char * ivarName = ivar_getName(myIvar);
        NSLog(@"%@",[NSString stringWithUTF8String:ivarName]);
    }
    NSLog(@"---------------------");
}



@end
