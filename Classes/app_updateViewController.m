//
//  app_updateViewController.m
//  app-update
//
//  Created by Marin Todorov on 3/27/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//

#import "app_updateViewController.h"


@interface app_updateViewController ()
@property (nonatomic, strong) UIView *containerView;

- (void)centerScrollViewContents;
@end




@implementation app_updateViewController

@synthesize btnUpdate, canvas, loader, fileManager, documentsDir;


@synthesize scrollView = _scrollView;

@synthesize containerView = _containerView;


- (void)viewDidLoad {
    [super viewDidLoad];
	

    
    
    
    
    
    
    //draggable buttons
    // create a label
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 50)] 
                      autorelease];
	label.text = @"Drag me!";
    
	// enable touch delivery
	label.userInteractionEnabled = YES;
    
	UIPanGestureRecognizer *gesture = [[[UIPanGestureRecognizer alloc] 
                                        initWithTarget:self 
                                        action:@selector(labelDragged:)] autorelease];
    
	UIPanGestureRecognizer *gesture2 = [[[UITapGestureRecognizer alloc] 
                                        initWithTarget:self 
                                        action:@selector(labelTapped:)] autorelease];
	[label addGestureRecognizer:gesture];
	[label addGestureRecognizer:gesture2];
    
    
    
    
    UILabel *updatelabel = [[[UILabel alloc] initWithFrame:CGRectMake(80, 10, 100, 50)] 
                      autorelease];
	updatelabel.text = @"Update Content!";
    updatelabel.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *gesture3 = [[[UIPanGestureRecognizer alloc] 
                                        initWithTarget:self 
                                        action:@selector(labelDragged:)] autorelease];
	UIPanGestureRecognizer *gesture4 = [[[UITapGestureRecognizer alloc] 
                                         initWithTarget:self 
                                         action:@selector(btnUpdateClicked)] autorelease];
	[updatelabel addGestureRecognizer:gesture3];
	[updatelabel addGestureRecognizer:gesture4];
    
    /*
     Tapping (any number of taps) 
     UITapGestureRecognizer
     Pinching in and out (for zooming a view)
     UIPinchGestureRecognizer
     Panning or dragging
     UIPanGestureRecognizer
     Swiping (in any direction)
     UISwipeGestureRecognizer
     Rotating (fingers moving in opposite directions)
     UIRotationGestureRecognizer
     Long press (also known as “touch and hold”)
     UILongPressGestureRecognizer
     */
    
	// add it
    
    
    
    
    
    //add sound effects
    NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:@"pew-pew-lei" ofType:@"caf"];
	NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
	AudioServicesCreateSystemSoundID((CFURLRef)pewPewURL, &_pewPewSound);


	//[self.view addSubview:label];
    

    

    
    //allow scrolling
    self.title = @"Custom View";
    
    // Set up the container view to hold our custom view hierarchy
    CGSize containerSize = CGSizeMake(640.0f, 640.0f);
    self.containerView = [[UIView alloc] initWithFrame:(CGRect){.origin=CGPointMake(0.0f, 0.0f), .size=containerSize}];
    [self.scrollView addSubview:self.containerView];
    
    // Set up our custom view hierarchy
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 640.0f, 80.0f)];
    redView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:redView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 560.0f, 640.0f, 80.0f)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.containerView addSubview:blueView];
    
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(160.0f, 160.0f, 320.0f, 320.0f)];
    greenView.backgroundColor = [UIColor greenColor];
    [self.containerView addSubview:greenView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"slow.png"]];
    imageView.center = CGPointMake(320.0f, 320.0f);
    [self.containerView addSubview:imageView];
    
    
    
    //initialization
	self.fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
	self.documentsDir = [paths objectAtIndex:0];
	
	//load the image gallery
	[self preloadImages];
	[self loadImagesInCanvas];
    
    
    
    // Tell the scroll view the size of the contents
    self.scrollView.contentSize = containerSize;
    
    //CGSize viewsize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    //self.scrollView.contentSize = viewsize;
    //NSLog(@"viewsize%@", self.view.frame.size.width);
    
    
    
    [self.view addSubview:self.scrollView];
    
	[self.view addSubview:label];
	[self.containerView addSubview:updatelabel];
    
        
    
}


//drag label
- (void)labelDragged:(UIPanGestureRecognizer *)gesture
{
	UILabel *label = (UILabel *)gesture.view;
	CGPoint translation = [gesture translationInView:label];
    
	// move label
	label.center = CGPointMake(label.center.x + translation.x, 
                               label.center.y + translation.y);
    
	// reset translation
	[gesture setTranslation:CGPointZero inView:label];
}

//tap label
- (void)labelTapped:(UITapGestureRecognizer *)gesture
{
	UILabel *label = (UILabel *)gesture.view;
    NSLog(@"Tapped");
    
    
    AudioServicesPlaySystemSound(_pewPewSound);

   /* NSString *soundFile = [[NSBundle mainBundle] pathForResource:@"fart18.mp3" ofType:@"mp3"];
    _backgroundMusicPlayer = [[AVAudioPlayer alloc]
                              initWithContentsOfURL:backgroundMusicURL error:&error];
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];
    */
}



- (void)viewDidUnload {
	self.documentsDir = nil;
	self.fileManager = nil;
    //    [super viewDidUnload];
        
        self.scrollView = nil;
        self.containerView = nil;
    
}

- (void)dealloc {
    [super dealloc];
}

-(void)btnUpdateClicked
{
	btnUpdate.hidden= YES;
	loader.hidden = NO;
	
	NSOperationQueue *queue = [NSOperationQueue new];
	
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self
																			selector:@selector(updateFromInternet)
																			  object:nil];
	
	[queue addOperation:operation];
	[operation release];
	[queue autorelease];
	
}

-(void)preloadImages
{
	
	for (NSString* fileName in [self.fileManager contentsOfDirectoryAtPath: [[NSBundle mainBundle] resourcePath] error:nil]) {
		if ( [fileName rangeOfString:@".jpeg"].location != NSNotFound  ) {
			NSLog(@"preload image: %@", fileName);
			
			NSString *pathLocal = [self.documentsDir stringByAppendingPathComponent:fileName];
			NSString *pathBundle = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
			[self.fileManager copyItemAtPath:pathBundle toPath:pathLocal error:nil];
		}
	}
	
}

-(void)loadImagesInCanvas
{
	//clean the canvas
//	for (UIView* img in self.canvas.subviews) {
   for (UIScrollView* img in self.containerView.subviews) {
		//[img removeFromSuperview];
		img = nil;
	}
	
	//load the images
	int row = 0;
	int col = 0;
	
	for (NSString* fileName in [self.fileManager contentsOfDirectoryAtPath: self.documentsDir error:nil]){
		if ( [fileName rangeOfString:@".jpeg"].location != NSNotFound  ) {
			
			NSLog(@"add %@", fileName);
			
			UIImage* img = [UIImage imageWithContentsOfFile:
								[self.documentsDir stringByAppendingPathComponent:fileName]
							];
			
			UIImageView* imgView = [[UIImageView alloc] initWithImage:img];
			imgView.frame = CGRectMake(col*100, row*100, 90, 90);
			
			//[self.canvas addSubview:imgView];
			[self.containerView addSubview:imgView];
			[imgView release];
			
		}
		
		if (col++>1) {
			row++;
			col = 0;
		}
	}
	
}

-(void)updateFromInternet
{
	//save to a temp file
	NSString* filePath = [NSString stringWithFormat:@"%@/temp.zip", self.documentsDir];
	NSString* updateURL = @"http://www.touch-code-magazine.com/wp-content/uploads/2010/04/app-update.zip";
	NSLog(@"Checking update at : %@", updateURL);
	NSData* updateData = [NSData dataWithContentsOfURL: [NSURL URLWithString: updateURL] ];
	
	[self.fileManager createFileAtPath:filePath contents:updateData attributes:nil];
	
	ZipArchive *zipArchive = [[ZipArchive alloc] init];
	
	if([zipArchive UnzipOpenFile:filePath]) {

		if ([zipArchive UnzipFileTo:self.documentsDir overWrite:YES]) {
			//unzipped successfully
			NSLog(@"Archive unzip Success");
			[self.fileManager removeItemAtPath:filePath error:NULL];
		} else {
			NSLog(@"Failure To Unzip Archive");				
		}
		
	} else  {
		NSLog(@"Failure To Open Archive");
	}
	
	[zipArchive release];
	
	[self performSelectorOnMainThread:@selector(didUpdate) withObject:nil waitUntilDone:YES];
}

-(void)didUpdate
{
	loader.hidden = YES;
	btnUpdate.hidden = NO;
	[self loadImagesInCanvas];
}




- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.containerView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.containerView.frame = contentsFrame;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the minimum & maximum zoom scales
    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}




- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UIScrollViewDelegate

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}








@end
