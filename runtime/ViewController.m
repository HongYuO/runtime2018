//
//  ViewController.m
//  runtime
//
//  Created by Zeke on 2018/4/12.
//  Copyright © 2018年 Zeke. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIImage+Runtime.h"
#import "Person+Name.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person * person = [[Person alloc]init];
    //1.创建对象方法：
    //调用对象方法
    [person eat];
    //本质：让对象发送消息
    objc_msgSend(person,@selector(eat));
    //objc_msgSend(id _Nullable self, SEL _Nonnull op, ...) 如果方法带参数，就再方法后面继续写入参数，如：[tableView cellForRowAtIndexPath:indexPath]可以写成消息发送的方法如下：objc_msgSend(tableView, @selector(cellForRowAtIndexPath:),indexPath);
    //2.创建类方法：
    //通过类名调用
    [Person Play];
    //本质：放类对象发送消息
    objc_msgSend([Person class], @selector(Play));
    
    //3.交换方法的使用
    UIImage * image = [UIImage imageNamed:@""];
    
    //4.给分类添加属性
    person.name = @"哈哈";
    NSLog(@"%@",person.name);
    
    //5.给对象添加关联对象(Associated)
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    btn.backgroundColor = [UIColor yellowColor];
    btn.tag = 100;
    [self.view addSubview:btn];
    objc_setAssociatedObject(btn, "AssociatedObj", @"BtnAssociated", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [btn addTarget:self action:@selector(touchAssociatedObj:) forControlEvents:UIControlEventTouchUpInside];
    
    //6.动态添加方法
    //开发场景：如果一个类方法非常多，加载类到内存的时候也比较耗费资源，需要给每个方法生成映射表，可以使用动态给某个类，添加方法解决。
    [person performSelector:@selector(addNewMethod)];
    //默认是没有实现addNewMethod方法的 通过调用addNewMethod方法会报错
    //需要再动态添加方法resolveInstanceMethod  再Person类中
    [person performSelector:@selector(addNum:) withObject:@10];
    
    
    //7.获取属性列表
    [person PropertyNum];
    //8.获取方法列表
    [person MethodListNum];
    //9.获取成员变量列表
    [person IVarListNum];
    //10.动态变量控制：eg:改变person的属性（或者成员变量）的值
    [self changePersonStr:person];
    
    
}
-(void)touchAssociatedObj:(id)btn
{
    UIButton * b = btn;
    NSString * str=objc_getAssociatedObject(b, "AssociatedObj");
    NSLog(@"%@---%lu",str,b.tag);
}
-(void)changePersonStr:(Person*)person
{
    unsigned int count;
    //这边将会给person 的 _str 属性增加一个值
    //获取person的所有成员变量
    Ivar * ivarList = class_copyIvarList([person class], &count);
    
    for (int i=0; i<count; i++) {
        Ivar ivar = ivarList[i];
        const char * ivarName = ivar_getName(ivar);
        NSString * name = [NSString stringWithUTF8String:ivarName];
        if ([name isEqualToString:@"_str"]) {
            object_setIvar(person, ivar, @"哈哈");
            break;
        }
    }
    
    NSLog(@"%@",person);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
