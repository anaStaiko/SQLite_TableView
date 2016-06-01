//
//  ViewController.h
//  SQLiteDB
//
//  Created by Anastasiia Staiko on 5/30/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfo.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, EditInfoDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblPeople;

- (IBAction)addNewRecord:(id)sender;


@end

