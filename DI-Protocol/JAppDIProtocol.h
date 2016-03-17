//
//  JAppDIProtocol.h
//  DI-Protocol
//
//  Created by 蔡杰Alan on 16/3/10.
//  Copyright © 2016年 Allan. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol JAppDIProtocol <NSObject>

- (void)injectDependencyObject:(id)object forProtocol:(Protocol *)protocol;

@end



/*
    生成单例
 */
extern id JAppDISingletonProxyCreate();

/*
   普通对象
 */
extern id JAppDIProxyCreate();


