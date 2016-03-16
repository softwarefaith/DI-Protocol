//
//  JAppDIProtocol.h
//  DI-Protocol
//
//  Created by 蔡杰Alan on 16/3/10.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JAppDIProtocol : NSProxy

@property(nonatomic, strong, readonly) NSHashTable* delegates;

+ (instancetype)sharedInstance;

- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol;



@end
