//
//  JAppDIProtocol.m
//  DI-Protocol
//
//  Created by 蔡杰Alan on 16/3/10.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import "JAppDIProtocol.h"
#import <objc/runtime.h>


@interface JAppDIProtocol : NSProxy<JAppDIProtocol>

-(instancetype)init;

- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol;

@end

@interface JAppDIProtocol ()
@property(nonatomic,strong) NSMutableDictionary *objectCache;
@end

@implementation JAppDIProtocol

+(instancetype)sharedInstance{
    static JAppDIProtocol *appDIProtocol = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appDIProtocol = [[JAppDIProtocol alloc]init];
    });
    return appDIProtocol;
}

-(instancetype)init{
    self.objectCache = [[NSMutableDictionary alloc]init];
    return self;
}

-(void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol{
    
    unsigned int numberOfMethods = 0;
    
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(protocol, YES, YES, &numberOfMethods);
    
    for (unsigned i = 0; i < numberOfMethods; i++) {
         struct objc_method_description method = methods[i];
        [_objectCache setValue:object forKey:NSStringFromSelector(method.name)];
    }
}

#pragma mark --Methods
-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    
    NSString *methodName = NSStringFromSelector(sel);
    id handler = [self.objectCache valueForKey:methodName];
    if (handler && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    }else{
        return [super methodSignatureForSelector:sel];
    }
    
}

-(void)forwardInvocation:(NSInvocation *)invocation{
    NSString *methodName = NSStringFromSelector(invocation.selector);
    id handler = [self.objectCache valueForKey:methodName];
    if (handler && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    }else{
        [super forwardInvocation:invocation];
    }
    
}

id JAppDISingletonProxyCreate()
{
    return [JAppDIProtocol sharedInstance];
}

id JAppDIProxyCreate()
{
    return [JAppDIProtocol sharedInstance];
}

@end
