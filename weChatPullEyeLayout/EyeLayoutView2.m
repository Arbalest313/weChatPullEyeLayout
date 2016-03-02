//
//  EyeLayoutView2.m
//  weChatPullEyeLayout
//
//  Created by huangyuan on 2/23/16.
//  Copyright © 2016 com.yuan.WeChatPull. All rights reserved.
//

#import "EyeLayoutView2.h"


#define kEyeLightRadius
@interface EyeLayoutView2 ()

@property (strong, nonatomic) CAShapeLayer *eyeFirstLightLayer;
@property (strong, nonatomic) CAShapeLayer *eyeballLayer;
@property (strong, nonatomic) CAShapeLayer *topEyesocketLayer;
@property (strong, nonatomic) CAShapeLayer *bottomEyesocketLayer;


@end


@implementation EyeLayoutView2
{
    BOOL _collapse;
    CGFloat _eyeLightRaidus;
    CGFloat _eyeBallRaidus;
    CGFloat _topCurvePoint;
    CGFloat _botCurvePoint;

}

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
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2 + CGRectGetWidth(self.frame) * 0.05f + 2, CGRectGetHeight(self.frame)/2 - (CGRectGetWidth(self.frame) * .05f ) - 2);

        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:center radius:_eyeLightRaidus startAngle:(0.f/180.f)*M_PI endAngle:(360.f/180.0f)*M_PI clockwise:YES];
        _eyeFirstLightLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeFirstLightLayer.lineWidth = 0.5f;
        _eyeFirstLightLayer.path = path.CGPath;
        _eyeFirstLightLayer.fillColor = [UIColor whiteColor].CGColor;
        _eyeFirstLightLayer.strokeColor = [UIColor whiteColor].CGColor;
    }
    return _eyeFirstLightLayer;
}

- (CAShapeLayer *)eyeballLayer {
    if (!_eyeballLayer) {
        _eyeballLayer = [CAShapeLayer layer];
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:_eyeBallRaidus startAngle:(0/180.f) * M_PI endAngle:(360.f / 180.f) * M_PI clockwise:YES];
        _eyeballLayer.borderColor = [UIColor blackColor].CGColor;
        _eyeballLayer.lineWidth = 1.f;
        _eyeballLayer.path = path.CGPath;
        _eyeballLayer.fillColor = [UIColor blackColor].CGColor;
        _eyeballLayer.strokeColor = [UIColor blackColor].CGColor;
        _eyeballLayer.anchorPoint = CGPointMake(0.5, 0.5);
        [_eyeballLayer addSublayer:self.eyeFirstLightLayer];
        [self.layer addSublayer:_eyeballLayer];
    }
    return _eyeballLayer;
}

- (CAShapeLayer *)topEyesocketLayer{
    if (!_topEyesocketLayer) {
        _topEyesocketLayer = [CAShapeLayer layer];
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.25, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.75, CGRectGetHeight(self.frame)/2) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, _topCurvePoint)];
        _topEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _topEyesocketLayer.strokeColor = [UIColor blackColor].CGColor;
        _topEyesocketLayer.path = path.CGPath;
        _topEyesocketLayer.lineWidth = 3.f;
        [self.layer addSublayer:_topEyesocketLayer];
        
    }
    return _topEyesocketLayer;
}


- (CAShapeLayer *)bottomEyesocketLayer{
    if (!_bottomEyesocketLayer) {
        _bottomEyesocketLayer = [CAShapeLayer layer];
        UIBezierPath * path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * .25f - 1, CGRectGetHeight(self.frame)/2)];
        [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.75f , CGRectGetHeight(self.frame)/2 - 1) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, _botCurvePoint)];
        _bottomEyesocketLayer.borderColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.fillColor = [UIColor clearColor].CGColor;
        _bottomEyesocketLayer.strokeColor = [UIColor blackColor].CGColor;
        _bottomEyesocketLayer.path = path.CGPath;
        _bottomEyesocketLayer.lineWidth = 3.f;
        [self.layer addSublayer:_bottomEyesocketLayer];
        
    }
    return _bottomEyesocketLayer;
}


- (void)setUpAnimate {
    _eyeBallRaidus = CGRectGetWidth(self.frame) * 0.1;
//    _eyeLightRaidus = CGRectGetWidth(self.frame)/4*0.1;
    _eyeLightRaidus = _eyeBallRaidus/3;

    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    _topCurvePoint = center.y - CGRectGetWidth(self.frame) * .2f - 5;
    _botCurvePoint = center.y + CGRectGetWidth(self.frame) * .2f + 5;
    self.topEyesocketLayer.lineWidth = 1.f;
    self.bottomEyesocketLayer.lineWidth = 1.f;
    self.eyeballLayer.lineWidth = 1.f;
    self.backgroundColor = [UIColor whiteColor];
    _collapse = NO;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(winkWink)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}

- (void)winkWink{
    if ((_collapse = !_collapse)) {
        _eyeBallRaidus = 0;
        _eyeLightRaidus = 0;
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        _topCurvePoint = center.y +  10;
        _botCurvePoint = center.y + 10;

    }else {
        _eyeBallRaidus = CGRectGetWidth(self.frame) * 0.1;
        _eyeLightRaidus = _eyeBallRaidus/3;
        CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
        _topCurvePoint = center.y - CGRectGetWidth(self.frame) * .2f - 5;
        _botCurvePoint = center.y + CGRectGetWidth(self.frame) * .2f + 5;

    }
    _topEyesocketLayer.fillColor = [UIColor clearColor].CGColor;

    [self updateAllShapes];
}



- (void)updateAllShapes {
    UIBezierPath * path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.25, CGRectGetHeight(self.frame)/2)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.75, CGRectGetHeight(self.frame)/2) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, _topCurvePoint)];
    if (_collapse) {
        [self addEyeLashs:path start:CGPointMake(CGRectGetWidth(self.frame) * 0.25, CGRectGetHeight(self.frame)/2)
                      end:CGPointMake(CGRectGetWidth(self.frame) * 0.75, CGRectGetHeight(self.frame)/2)
               curvePoint:CGPointMake(CGRectGetWidth(self.frame)/2, _topCurvePoint)];
        _topEyesocketLayer.fillColor = [UIColor blackColor].CGColor;
    }
    _topEyesocketLayer.path = path.CGPath;
    
    path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(CGRectGetWidth(self.frame) * .25f - 1, CGRectGetHeight(self.frame)/2)];
    [path addQuadCurveToPoint:CGPointMake(CGRectGetWidth(self.frame) * 0.75f , CGRectGetHeight(self.frame)/2 - 1) controlPoint:CGPointMake(CGRectGetWidth(self.frame)/2, _botCurvePoint)];
    _bottomEyesocketLayer.path = path.CGPath;
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.frame)/2 + CGRectGetWidth(self.frame) * 0.05f + 2, CGRectGetHeight(self.frame)/2 - (CGRectGetWidth(self.frame) * .05f ) - 2);
    _eyeFirstLightLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:_eyeLightRaidus startAngle:(0.f/180.f)*M_PI endAngle:(360.f/180.0f)*M_PI clockwise:YES].CGPath;
    
    
     center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    _eyeballLayer.path = [UIBezierPath bezierPathWithArcCenter:center radius:_eyeBallRaidus startAngle:(0/180.f) * M_PI endAngle:(360.f / 180.f) * M_PI clockwise:YES].CGPath;
    
}

- (void)addEyeLashs:(UIBezierPath *)path start:(CGPoint)startPoint end:(CGPoint)endPoint curvePoint:(CGPoint)curvePoint{
    CGFloat delta = endPoint.x - startPoint.x;
    CGFloat deltaY = CGRectGetHeight(self.frame);
    CGFloat lastX = endPoint.x + delta * .1f;
    CGFloat lastY = endPoint.y + deltaY * .03f;
    
    //eyelash right most
    CGPoint nextPoint = CGPointMake(lastX,lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .05f, nextPoint.y - 1 )];
    nextPoint = [self getPointFrom:1 -  0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x , nextPoint.y + 2)];

    //eyelash right 2
    nextPoint = [self getPointFrom:1 -  2* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .06f;
    lastY = nextPoint.y + deltaY * .06f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .06f, nextPoint.y - 1 )];
    nextPoint = [self getPointFrom:1 -  3 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .04f , nextPoint.y + 5)];

    //eyelash right 3
    nextPoint = [self getPointFrom:1 -  5* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .06f;
    lastY = nextPoint.y + deltaY * .06f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .04f, nextPoint.y - 1 )];
    nextPoint = [self getPointFrom:1 -  6 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .02f , nextPoint.y + 5)];

    
    //eyelash right 4
    nextPoint = [self getPointFrom:1 -  8* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .06f;
    lastY = nextPoint.y + deltaY * .05f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .00f, nextPoint.y - 1 )];
    nextPoint = [self getPointFrom:1 -  9 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x - delta * .0f , nextPoint.y + 2)];


    //eyelash mid 5
    nextPoint = [self getPointFrom:1 -  11* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .04f;
    lastY = nextPoint.y + deltaY * .05f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .02f, nextPoint.y + 1 )];
    nextPoint = [self getPointFrom:1 -  13 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .02f , nextPoint.y - 2)];

    //eyelash left 6
    nextPoint = [self getPointFrom:1 -  14* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .03f;
    lastY = nextPoint.y + deltaY * .06f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .03f, nextPoint.y - 2)];
    nextPoint = [self getPointFrom:1 -  16 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .03f , nextPoint.y - 2)];
    
    
    //eyelash left 7
    nextPoint = [self getPointFrom:1 -  17* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .03f;
    lastY = nextPoint.y + deltaY * .06f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .03f, nextPoint.y - 2)];
    nextPoint = [self getPointFrom:1 -  19 *0.05 start:startPoint end:endPoint curve:curvePoint];
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .03f , nextPoint.y - 2)];
    
    //eyelash left most
    nextPoint = [self getPointFrom:1 -  20* 0.05  start:startPoint end:endPoint curve:curvePoint];
    [path addLineToPoint:nextPoint];
    
    lastX = nextPoint.x + delta * .03f;
    lastY = nextPoint.y + deltaY * .06f;
    nextPoint = CGPointMake(lastX, lastY);
    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .04f, nextPoint.y - deltaY * .06f)];
//    nextPoint = [self getPointFrom:1 -  21 *0.05 start:startPoint end:endPoint curve:curvePoint];
//    [path addQuadCurveToPoint:nextPoint controlPoint:CGPointMake(nextPoint.x + delta * .03f , nextPoint.y - 2)];

    [path closePath];

}

- (CGPoint)getPointFrom:(CGFloat)percent start:(CGPoint)start end:(CGPoint)end curve:(CGPoint)curve{
    CGFloat x = QuadBezier(percent, start.x, curve.x, end.x);
    CGFloat y = QuadBezier(percent, start.y, curve.y, end.y);
    return CGPointMake(x, y);
}

float CubicBezier(float t, float start, float c1, float c2, float end)
{
    CGFloat t_ = (1.0 - t);
    CGFloat tt_ = t_ * t_;
    CGFloat ttt_ = t_ * t_ * t_;
    CGFloat tt = t * t;
    CGFloat ttt = t * t * t;
    
    return start * ttt_
    + 3.0 *  c1 * tt_ * t
    + 3.0 *  c2 * t_ * tt
    + end * ttt;
}

float QuadBezier(float t, float start, float c1, float end)
{
    CGFloat t_ = (1.0 - t);
    CGFloat tt_ = t_ * t_;
    CGFloat tt = t * t;
    
    return start * tt_
    + 2.0 *  c1 * t_ * t
    + end * tt;
}
@end
