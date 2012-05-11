//
//  app_updateAppDelegate.h
//  app-update
//
//  Created by Marin Todorov on 3/27/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class app_updateViewController;

@interface app_updateAppDelegate : NSObject <UIApplicationDelegate, AVAudioPlayerDelegate>  {
    UIWindow *window;
    app_updateViewController *viewController;
    
    
	AVAudioPlayer *_backgroundMusicPlayer;
	BOOL _backgroundMusicPlaying;
	BOOL _backgroundMusicInterrupted;
	UInt32 _otherMusicIsPlaying;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet app_updateViewController *viewController;


- (void)tryPlayMusic;

@end

