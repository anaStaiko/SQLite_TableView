//
//  EditInfo.h
//  SQLiteDB
//
//  Created by Anastasiia Staiko on 5/31/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"



@protocol EditInfoDelegate

-(void)editingInfoWasFinished;

@end

@interface EditInfo : UIViewController <UITextFieldDelegate>


@property (nonatomic, strong) id<EditInfoDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;

@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;

- (IBAction)save:(id)sender;




@property (nonatomic) int recordIDToEdit;


@property (strong, nonatomic) NSString *databasePath;

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic, strong) NSString *databaseFilename;

@end
