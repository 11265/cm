#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PTFakeMetaTouch.h"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 示例：在屏幕中心模拟点击
        CGPoint centerPoint = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        
        NSInteger touchId = [PTFakeMetaTouch getAvailablePointId];
        
        // 开始触摸
        [PTFakeMetaTouch fakeTouchId:touchId AtPoint:centerPoint withTouchPhase:UITouchPhaseBegan];
        
        // 结束触摸
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [PTFakeMetaTouch fakeTouchId:touchId AtPoint:centerPoint withTouchPhase:UITouchPhaseEnded];
        });
    });
}

%end