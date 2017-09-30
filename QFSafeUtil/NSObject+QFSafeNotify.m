//
//  NSObject+QFSafeNotify.m
//  TestProject
//
//  Created by dqf on 2017/9/30.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "NSObject+QFSafeNotify.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface NSObject (QFNotify)
@property (nonatomic, copy) NSObject *observer;
@end

@implementation NSObject (QFSafeNotify)

- (NSObject *)observer {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setObserver:(NSObject *)observer {
    objc_setAssociatedObject(self, @selector(observer), observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)registerNoti:(NSString *)name callback:(void(^)(NSNotification * note))callback {
    if (name == nil) return;
    self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        if (callback) {
            callback(note);
        }
    }];
}

- (void)postNoti:(NSString *)name {
    if (name == nil) return;
    [self postNoti:name object:nil];
}

- (void)postNoti:(NSString *)name object:(id)anObject {
    if (name == nil) return;
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:anObject];
}

@end
