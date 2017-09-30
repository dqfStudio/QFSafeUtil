//
//  NSURL+QFSafeUtil.m
//  TestProject
//
//  Created by dqf on 2017/9/30.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "NSURL+QFSafeUtil.h"

@implementation NSURL (QFSafeUtil)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[self class] methodSwizzleWithOrigSEL:@selector(fileURLWithPath:) overrideSEL:@selector(safe_fileURLWithPath:)];
    });
}
+ (instancetype)safe_fileURLWithPath:(NSString *)path {
    if([path isKindOfClass:[NSString class]]){
        return [self safe_fileURLWithPath:path];
    } else {
#if DEBUG
        NSAssert(NO,nil);
#endif
    }
    return nil;
}
@end

