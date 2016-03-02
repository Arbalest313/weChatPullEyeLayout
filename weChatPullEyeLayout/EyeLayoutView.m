//
//  EyeLayoutView.m
//  weChatPullEyeLayout
//
//  Created by huangyuan on 2/18/16.
//  Copyright © 2016 com.yuan.WeChatPull. All rights reserved.
//

#import "EyeLayoutView.h"
@interface EyeLayoutView ()

@property (strong, nonatomic) CAShapeLayer *eyeFirstLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeSecondLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeballLayer;
@property (strong, nonatomic) CAShapeLayer *topEyesocketLayer;
@property (strong, nonatomic) CAShapeLayer *bottomEyesocketLayer;
@end


@implementation EyeLayoutView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpAnimate];
    }
    return self;
}
-(CAShapeLayer *)eyeFirstLightLayer {
    if (!_eyeFirstLightLayer) {
        _eyeFirstLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(self.frame)/2*0.1 startAngle:(230.f/180.f)*M_PI endAngle:(265.f/180.0f)*M_PI clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blueColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 0.5f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_eyeFirstLightLayer];
    }
    return _eyeFirstLightLayer;
}


- (CAShapeLayer *)eyeSecondLightLayer {
    if (!_eyeSecondLightLayer) {
        _eyeSecondLightLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/ 2, CGRectGetHeight(self.frame)/ 2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                            radius:CGRectGetWidth(self.frame)/2 * 0.1
                                                        startAngle:(211.f / 180.f) * M_PI
                                                          endAngle:(220.f / 180.f) * M_PI
                                                         clockwise:YES];
        _eyeSecondLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeSecondLightLayer.lineWidth = 5.f;
        _eyeSecondLightLayer.path = path.CGPath;
        _eyeSecondLightLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeSecondLightLayer.strokeColor = [UIColor whiteColor].CGColor;
        [self.layer addSublayer:_eyeSecondLightLayer];

    }
    return _eyeSecondLightLayer;
}


- (CAShapeLayer *)eyeballLayer {
    if (!_eyeballLayer) {
        _eyeballLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:CGRectGetWidth(self.frame)/2 * 0.1 + 5 startAngle:(0/180.f) * M_PI endAngle:(360.f / 180.f) * M_PI clockwise:YES];
        _eyeballLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor clearColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor whiteColor].CGColor;
        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
        [self.layer addSublayer:_eyeballLayer];
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer{
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.375, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.625, CGRectGetHeight(self.frame)/2) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, center.y - CGRectGetWidth(self.frame) * .1f - 10 - 1)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.lineWidth = 1.f;
        [self.layer addSublayer:_topEyesocketLayer];

    }
    return _topEyesocketLayer;
}


- (CAShapeLayer *)bottomEyesocketLayer{
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.375, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.625, CGRectGetHeight(self.frame)/2) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, center.y + CGRectGetWidth(self.frame) * .1f + 10 + 1)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor whiteColor].CGColor;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.lineWidth = 1.f;
        [self.layer addSublayer:_bottomEyesocketLayer];

    }
    return _bottomEyesocketLayer;
}


- (void)setUpAnimate {
    self.eyeFirstLightLayer.lineWidth = .0f;
    self.eyeSecondLightLayer.lineWidth = .0f;
    self.eyeballLayer.lineWidth = .0f;
    self.bottomEyesocketLayer.strokeStart = 0.5f;
    _bottomEyesocketLayer.strokeEnd = 0.5f;
    self.topEyesocketLayer.strokeStart = 0.5f;
    _topEyesocketLayer.strokeEnd = 0.5f;
    self.backgroundColor = [UIColor blackColor];
}




- (void)animationWiht:(CGFloat)y {
    NSLog(@"y:%f, origin:%f",y, self.frame.origin.y);
    CGFloat flag = self.frame.origin.y * 2 - 40.f ;
    if (y < flag) {
        if (_eyeFirstLightLayer.lineWidth < 5.f) {
            _eyeFirstLightLayer.lineWidth += 1.f;
            _eyeSecondLightLayer.lineWidth += 1.f;
       }
    }
    
    if (y < flag - 20.f) {
        if (_eyeballLayer.lineWidth < 1.f) {
            _eyeballLayer.lineWidth += 0.1f;
        }
    }
    
    
    if (y < flag - 40.f) {
        if (_topEyesocketLayer.strokeEnd > .0f && _bottomEyesocketLayer.strokeEnd < 1.f ) {
            _topEyesocketLayer.strokeEnd += .1f;
            _topEyesocketLayer.strokeStart -= 0.1;
            _bottomEyesocketLayer.strokeEnd += .1f;
            _bottomEyesocketLayer.strokeStart -= 0.1;
            
        }
    }
    
    if (y > flag) {
        if (_eyeFirstLightLayer.lineWidth > 0.f) {
            _eyeFirstLightLayer.lineWidth -= 1.f;
            _eyeSecondLightLayer.lineWidth -= 1.f;
        }
    }
    
    
    if (y > flag - 20.f) {
        if (_eyeballLayer.lineWidth > 0.f) {
            _eyeballLayer.lineWidth -= 0.1f;
        }
    }
    
    if (y > flag - 40.f) {
        if (_topEyesocketLayer.strokeEnd > .5f && _bottomEyesocketLayer.strokeEnd < 5.f ) {
            _topEyesocketLayer.strokeEnd -= .1f;
            _topEyesocketLayer.strokeStart += 0.1;
            _bottomEyesocketLayer.strokeEnd -= .1f;
            _bottomEyesocketLayer.strokeStart += 0.1;
            
        }
    }

}

@end
