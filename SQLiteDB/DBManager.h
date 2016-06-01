//
//  DBManager.h
//  SQLiteDB
//
//  Created by Anastasiia Staiko on 5/30/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

-(void)copyDatabaseIntoDocumentsDirectory;

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

-(NSArray *)loadDataFromDB:(NSString *)query;

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic, strong) NSString *databaseFilename;
@property(nonatomic, strong) NSMutableArray *arrResults;

@property(nonatomic, strong) NSMutableArray *arrColumnNames;
@property(nonatomic) int affectedRows;
@property(nonatomic) long long lastInsertedRowID;

-(void)executeQuery:(NSString *)query;


@end
