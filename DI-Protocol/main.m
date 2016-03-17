//
//  main.m
//  DI-Protocol
//
//  Created by 蔡杰Alan on 16/3/10.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "info1.h"
#import "info.h"
#import "User.h"
#import "JAppDIProtocol.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        User *user = [[User alloc] init];
        id <info,JAppDIProtocol> appDI = JAppDIProxyCreate();
        [appDI injectDependencyObject:user forProtocol:@protocol(info)];
        [appDI printName];
    }
    return 0;
}
