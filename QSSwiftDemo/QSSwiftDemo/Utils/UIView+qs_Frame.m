//
//  UIView+qs_Frame.m
//  QSSwiftDemo
//
//  Created by tianmaotao on 2022/8/27.
//

#import "UIView+qs_Frame.h"

@implementation UIView (qs_Frame)

- (CGFloat)viewMinX; {
    return self.frame.origin.x;
}

- (CGFloat)viewMaxX {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)viewMinY {
    return self.frame.origin.y;
}

- (CGFloat)viewMaxY {
    return self.frame.origin.y + self.frame.size.height;
}

@end
