//
//  app_updateViewController.h
//  app-update
//
//  Created by Marin Todorov on 3/27/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZipArchive.h"
#import <AudioToolbox/AudioToolbox.h>

@interface app_updateViewController : UIViewController <UIScrollViewDelegate> {
	IBOutlet UIView* canvas;
    
	IBOutlet UIButton* btnUpdate;
	IBOutlet UIActivityIndicatorView* loader;
	
	NSFileManager *fileManager;
	NSString *documentsDir;

    SystemSoundID _pewPewSound;



}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (retain, nonatomic) IBOutlet UIView* canvas;
@property (retain, nonatomic) IBOutlet UIButton* btnUpdate;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView* loader;

@property (retain, nonatomic) NSFileManager *fileManager;
@property (retain, nonatomic) NSString *documentsDir;

-(IBAction)btnUpdateClicked;
-(void)updateFromInternet;

-(void)preloadImages;
-(void)loadImagesInCanvas;

@end

