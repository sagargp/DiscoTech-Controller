//
//  RobotLayer.m
//  DiscoTech Controller
//
//  Created by D. Grayson Smith on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RobotLayer.h"

#import "SneakyButton.h"
#import "SneakyJoystick.h"
#import "SneakyButtonSkinnedBase.h"
#import "SneakyJoystickSkinnedBase.h"
#import "ColoredCircleSprite.h"
#import "ColoredSquareSprite.h"

#import "SendUDP.h"

@implementation RobotLayer
int count = 0;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	RobotLayer *layer = [RobotLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    NSLog(@"initializing joysticks");
    self = [super init];
    if (self) {        
        // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        check = [CCLabelTTF labelWithString:@"" 
                                   fontName:@"Helvetica" 
                                   fontSize:20];
        check.position =            ccp(size.width/2, 20);
        [self addChild:check];
        
        
        SneakyJoystickSkinnedBase *leftJoy = [[SneakyJoystickSkinnedBase alloc] init];
        leftJoy.position = ccp(110, size.height/2);
        leftJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:75];
        leftJoy.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:40];
        leftJoy.joystick = [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 100, 100)] autorelease];
        leftJoystick = [leftJoy.joystick retain];
        leftJoystick.deadRadius = 10;
        leftJoystick.hasDeadzone = YES;
        [self addChild:leftJoy];
        [leftJoy release];
        [leftJoystick release];

        SneakyJoystickSkinnedBase *rightJoy = [[SneakyJoystickSkinnedBase alloc] init];
        rightJoy.position = ccp(size.width-110, size.height/2);
        rightJoy.backgroundSprite = [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:75];
        rightJoy.thumbSprite = [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:40];
        rightJoy.joystick = [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 100, 100)] autorelease];
        rightJoystick = [rightJoy.joystick retain];
        rightJoystick.deadRadius = 10;
        rightJoystick.hasDeadzone = YES;
        [self addChild:rightJoy];
        [rightJoy release];
        [rightJoystick release];
        
        /*
        SneakyJoystickSkinnedBase *leftArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        leftArmJoy.position =           ccp(280, 270);
        leftArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        leftArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        leftArmJoy.joystick =           [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)] autorelease];
        leftArmJoystick = [leftArmJoy.joystick retain];
        [self addChild:leftArmJoy];
        
        SneakyJoystickSkinnedBase *rightArmJoy = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
        rightArmJoy.position =           ccp(380, 270);
        rightArmJoy.backgroundSprite =   [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        rightArmJoy.thumbSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 0, 255, 200) radius:16];
        rightArmJoy.joystick =           [[[SneakyJoystick alloc] initWithRect:CGRectMake(0, 0, 32, 32)] autorelease];
        rightArmJoystick = [rightArmJoy.joystick retain];
        [self addChild:rightArmJoy];
        
        SneakyButtonSkinnedBase *ledBut = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
        ledBut.position =           ccp(330, 190);
        ledBut.defaultSprite =      [ColoredCircleSprite circleWithColor:ccc4(255, 0, 0, 128) radius:32];
        //ledBut.activatedSprite =    [CCSprite spriteWithFile:@"p3.png"];
        ledBut.pressSprite =        [ColoredCircleSprite circleWithColor:ccc4(0, 255, 0, 128) radius:32];
        ledBut.button =             [[[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 64, 64)] autorelease];
        led = [ledBut.button retain];
        led.isToggleable = NO;
        led.isHoldable = YES;
        [self addChild:ledBut];
        */
        
		[self scheduleUpdate];
    }
    return self;
}

-(void) update: (ccTime) dt
{
    int t,s;
    float ttemp, stemp;
    ttemp = leftJoystick.stickPosition.y;
    t = roundf(((ttemp + 100)*255)/200);
    stemp = leftJoystick.stickPosition.x;
    s = roundf(((stemp+100)*255)/200);
    
    int h,v;
    float htemp, vtemp;
    htemp = rightJoystick.stickPosition.x;
    h = roundf(((htemp+50)*255)/100);
    vtemp = rightJoystick.stickPosition.y;
    v = roundf(((vtemp+50)*255)/100);

    int l, r, ledOn;
    /*
    int l,r;
    float ltemp,rtemp;
    ltemp = leftArmJoystick.stickPosition.y;
    l = roundf(((ltemp+32)*255)/64);
    rtemp = rightArmJoystick.stickPosition.y;
    r = roundf(((rtemp+32)*255)/64);
    */
    
    data[0] = (unsigned char) 'b';
    data[1] = (unsigned char) t;
    data[2] = (unsigned char) s;
    data[3] = (unsigned char) h;
    data[4] = (unsigned char) v;
    data[5] = (unsigned char) l;
    data[6] = (unsigned char) r;
    data[7] = (unsigned char) 128;
    data[8] = (unsigned char) ledOn;
    data[9] = (unsigned char) 'e';
    
    //check.string = [NSString stringWithCharacters:data length:10];
    NSLog(@"Sending packet: %s", data);
    SUDP_SendMsg(data, 10);
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
