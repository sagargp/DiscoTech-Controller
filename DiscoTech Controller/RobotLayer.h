//
//  RobotLayer.h
//  DiscoTech Controller
//
//  Created by D. Grayson Smith on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import "SceneManager.h"

@class SneakyJoystick;
@class SneakyButton;

@interface RobotLayer : CCLayer
{
    SneakyJoystick *leftJoystick;
    SneakyJoystick *rightJoystick;
    SneakyButton *b1;
    SneakyButton *b2;
    
    CCLabelTTF *check;
    
    unsigned char data[6];
}

-(void)back:(id)sender;

+(CCScene *) scene;

@end

