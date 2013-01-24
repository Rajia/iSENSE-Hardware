//
//  ManualView.m
//  Splash
//
//  Created by Mike Stowell on 12/28/12.
//  Copyright 2012 iSENSE Development Team. All rights reserved.
//  Engaging Computing Lab, Advisor: Fred Martin
//

#import "ManualViewController.h"
#import "Data_CollectorAppDelegate.h"

#define MENU_UPLOAD 0
#define MENU_EXPERIMENT 1
#define MENU_LOGIN 2
#define EXPERIMENT_MANUAL_ENTRY 3
#define EXPERIMENT_BROWSE_EXPERIMENTS 4
#define EXPERIMENT_SCAN_QR_CODE 5

#define OPTION_CANCELED 0
#define OPTION_ENTER_EXPERIMENT_NUMBER 1
#define OPTION_BROWSE_EXPERIMENTS 2
#define OPTION_SCAN_QR_CODE 3

@implementation ManualViewController

@synthesize logo, loggedInAsLabel, expNumLabel, save, clear, sessionNameInput, media, scrollView;
@synthesize sessionName, expNum;


 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
	 [super viewDidLoad];
	 
	 [self.view sendSubviewToBack:scrollView];
	 
	 [self.sessionNameInput addTarget:self
						  action:@selector(textFieldFinished:)
				forControlEvents:UIControlEventEditingDidEndOnExit];
	 sessionNameInput.enablesReturnKeyAutomatically = NO;
	 
	 UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(displayMenu:)];          
	 self.navigationItem.rightBarButtonItem = menuButton;
	 [menuButton release];
	 
	 iapi = [iSENSE getInstance];
     [iapi toggleUseDev:YES];
	 
	 [self initLocations]; //* make initLocations.. ya know.. do something
	 
     if ([iapi isLoggedIn]) {
         loggedInAsLabel.text = [StringGrabber concatenateHardcodedString:@"logged_in_as" with:[iapi getLoggedInUsername]];
     } else {
         loggedInAsLabel.text = [StringGrabber concatenateHardcodedString:@"logged_in_as" with:@"_"]; 
     }
     
     //* get exp. # from prefs
	 expNumLabel.text = [StringGrabber concatenateHardcodedString:@"exp_num" with:@"_"];
	 
	 //* if exp. # is null, launch the dialog for choosing exp. num
 
 
 
     NSLog(@"ExperimentNum = %@", expNum);
 }

- (IBAction)textFieldFinished:(id)sender {}
 

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[logo release];
	[loggedInAsLabel release];
	[expNumLabel release];
	[save release];
	[clear release];
	[sessionNameInput release];
	[media release];
	[scrollView release];
	
	[sessionName release];
    
	[super dealloc];
}

- (IBAction) saveOnClick:(id)sender {
	//* if exp is null, toast
	//* else if sessionName's length = 0, .setError
	//* else SavaDataTask
}

- (IBAction) clearOnClick:(id)sender {
	sessionNameInput.text = @"";
	//* loop through UITextFields and clear them out
}

- (IBAction) mediaOnClick:(id)sender {
	//* useCamera iff sessionNameInput.length != 0
	[CameraUsage useCamera];
}

- (IBAction) displayMenu:(id)sender {
	UIActionSheet *popupQuery = [[UIActionSheet alloc] 
				  initWithTitle:nil 
			           delegate:self
	          cancelButtonTitle:@"Cancel" 
	     destructiveButtonTitle:nil 
			  otherButtonTitles:@"Upload", @"Experiment", @"Login", nil];
	popupQuery.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	[popupQuery showInView:self.view];
	[popupQuery release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	BOOL showMsg = YES;
	UIAlertView *message = [UIAlertView alloc];
    
	switch (buttonIndex) {
		case MENU_UPLOAD:
			message = [[UIAlertView alloc] initWithTitle:@"Upload"
                                                 message:@"Would you like to upload your data to iSENSE?"
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Okay", nil];
            
            message.tag = MENU_UPLOAD;
            //[message setAlertViewStyle:UIAlertViewStyleDefault];
            
			break;
            
		case MENU_EXPERIMENT:
            message = [[UIAlertView alloc] initWithTitle:@"Experiment Selection"
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Enter Experiment #", @"Browse", @"Scan QR Code", nil];
            
            message.tag = MENU_EXPERIMENT;
            
			break;
            
		case MENU_LOGIN:
            message = [[UIAlertView alloc] initWithTitle:@"Login"
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Okay", nil];
            
            message.tag = MENU_LOGIN;
			[message setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
            
            break;
            
		default:
			showMsg = NO;
			break;
	}
	
	if (showMsg)
		[message show];
	
    [message release];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == MENU_LOGIN) {
        
        if (buttonIndex != OPTION_CANCELED) {
            NSString *usernameInput = [[actionSheet textFieldAtIndex:0] text];
            NSString *passwordInput = [[actionSheet textFieldAtIndex:1] text];
            [self login:usernameInput withPassword:passwordInput];
        }
        
    } else if (actionSheet.tag == MENU_EXPERIMENT){
        
        if (buttonIndex == OPTION_ENTER_EXPERIMENT_NUMBER) {
            
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Enter Experiment #:"
                                                 message:nil
                                                delegate:self
                                       cancelButtonTitle:@"Cancel"
                                       otherButtonTitles:@"Okay", nil];
            
            message.tag = EXPERIMENT_MANUAL_ENTRY;
            [message setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [message show];
            [message release];
            
        } else if (buttonIndex == OPTION_BROWSE_EXPERIMENTS) {
            
        } else if (buttonIndex == OPTION_SCAN_QR_CODE) {
            
        }
        
    } else if (actionSheet.tag == MENU_UPLOAD) {
        
    } else if (actionSheet.tag == EXPERIMENT_MANUAL_ENTRY) {
        
        if (buttonIndex != OPTION_CANCELED) {
            
            expNum = [NSNumber numberWithInt: [[[actionSheet textFieldAtIndex:0] text] intValue]];
            NSLog(@"ExperimentNum = %@", expNum);
        }
        
    } else if (actionSheet.tag == EXPERIMENT_BROWSE_EXPERIMENTS) {
        
    } else if (actionSheet.tag == EXPERIMENT_SCAN_QR_CODE) {
        
    }
}

// TODO - make this actually restrict character limits
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if (textField == sessionNameInput) {
		NSUInteger newLength = [textField.text length] + [string length] - range.length;
		return (newLength > 25) ? NO : YES;
	}
	return YES;
}

- (void) login:(NSString *)usernameInput withPassword:(NSString *)passwordInput {
    if ([iapi login:usernameInput with:passwordInput]) {
        [self.view makeToast:@"Login Successful!"
                    duration:2.0
                    position:@"bottom"
                       image:@"check"];
        loggedInAsLabel.text = [StringGrabber concatenateHardcodedString:@"logged_in_as" with:[iapi getLoggedInUsername]];
	} else {
        [self.view makeToast:@"Login Failed!"
                    duration:2.0
                    position:@"bottom"
                       image:@"red_x"];
    }
}

- (void) experiment {
	[self.view makeToast:@"Experiment!"
				duration:2.0
				position:@"bottom"
                   image:@"red_x"];
}

- (void) upload {
	[self.view makeToast:@"Upload!"
				duration:2.0
				position:@"bottom"
                   image:@"check"];
	
}

// TODO gets data from the exp. #
- (void) getDataFromExpNumber {
	
}

// TODO allows for GPS to be recorded
- (void) initLocations {
	
}

// TODO
- (void) fillDataFieldEntryList:(int)eid {
	/*
	 for (ExperimentField expField : fieldOrder) {
	 
		if (expField.type_id == expField.GEOSPACIAL) {
			if (expField.unit_id == expField.UNIT_LATITUDE) {
				addDataField(expField, TYPE_LATITUDE);
			} else {
				addDataField(expField, TYPE_LONGITUDE);
			}
		} else if (expField.type_id == expField.TIME) {
			addDataField(expField, TYPE_TIME);
		} else {
			addDataField(expField, TYPE_DEFAULT);
		}
	 }
	 
	 checkLastImeOptions();
	 */
}

// TODO
- (void) addDataField:(NSString *)expField andType:(int)type {
	/*
	LinearLayout dataField = (LinearLayout) View.inflate(this,
														 R.layout.manualentryfield, null);
	TextView fieldName = (TextView) dataField
	.findViewById(R.id.manual_dataFieldName);
	fieldName.setText(expField.field_name);
	EditText fieldContents = (EditText) dataField
	.findViewById(R.id.manual_dataFieldContents);
	
	fieldContents.setSingleLine(true);
	fieldContents.setImeOptions(EditorInfo.IME_ACTION_NEXT);
	
	if (type != TYPE_DEFAULT) {
		fieldContents.setText("Auto");
		fieldContents.setEnabled(false);
		
		fieldContents.setClickable(false);
		fieldContents.setCursorVisible(false);
		fieldContents.setFocusable(false);
		fieldContents.setFocusableInTouchMode(false);
		fieldContents.setTextColor(Color.GRAY);
	}
	
	if (expField.type_id == expField.TEXT) {
		// keyboard to text
		fieldContents.setInputType(InputType.TYPE_CLASS_TEXT);
		fieldContents
		.setFilters(new InputFilter[] { new InputFilter.LengthFilter(
																	 60) });
		fieldContents.setKeyListener(DigitsKeyListener
									 .getInstance(getResources().getString(
																		   R.string.digits_restriction)));
	} else {
		// keyboard to nums
		fieldContents.setInputType(InputType.TYPE_CLASS_PHONE);
		fieldContents
		.setFilters(new InputFilter[] { new InputFilter.LengthFilter(
																	 20) });
		fieldContents.setKeyListener(DigitsKeyListener
									 .getInstance(getResources().getString(
																		   R.string.numbers_restriction)));
		
	}
	
	dataFieldEntryList.addView(dataField);	
	 */
}

@end
