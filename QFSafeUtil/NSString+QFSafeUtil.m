//
//  NSString+QFSafeUtil.m
//  TestProject
//
//  Created by dqf on 2017/9/30.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "NSString+QFSafeUtil.h"

@implementation NSString (QFSafeUtil)
#if DEBUG
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [objc_getClass("__NSCFConstantString") methodSwizzleWithOrigSEL:@selector(hasSuffix:) overrideSEL:@selector(safe_hasSuffix:)];
        [objc_getClass("__NSCFConstantString") methodSwizzleWithOrigSEL:@selector(hasPrefix:) overrideSEL:@selector(safe_hasPrefix:)];
        [objc_getClass("__NSCFConstantString") methodSwizzleWithOrigSEL:@selector(initWithString:) overrideSEL:@selector(safe_initWithString:)];
    });
}
- (BOOL)safe_hasSuffix:(NSString *)str {
    if([str isKindOfClass:[NSString class]]){
        return [self safe_hasSuffix:str];
    } else {
        NSAssert(NO,nil);
    }
    return NO;
}
- (BOOL)safe_hasPrefix:(NSString *)str {
    if([str isKindOfClass:[NSString class]]){
        return [self safe_hasPrefix:str];
    } else {
        NSAssert(NO,nil);
    }
    return NO;
}
- (instancetype)safe_initWithString:(NSString *)str {
    if([str isKindOfClass:[NSString class]]){
        return [self safe_initWithString:str];
    } else {
        NSAssert(NO,nil);
    }
    return nil;
}
#endif
@end
