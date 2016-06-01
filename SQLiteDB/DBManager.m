//
//  DBManager.m
//  SQLiteDB
//
//  Created by Anastasiia Staiko on 5/30/16.
//  Copyright © 2016 Anastasiia Staiko. All rights reserved.
//

#import "DBManager.h"



@implementation DBManager


-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable {
    
    sqlite3 *sqlite3Database;
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
        
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult == SQLITE_OK) {
        sqlite3_stmt *compiledStatement;
        
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if (prepareStatementResult == SQLITE_OK) {
            if (!queryExecutable) {
                NSMutableArray *arrDataRow;
                
                while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    for (int i=0; i<totalColumns; i++) {
                        char *dbDataAdChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        if(dbDataAdChars != NULL){
                            [arrDataRow addObject:[NSString stringWithUTF8String:dbDataAdChars]];
                            
                        }
                        
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAdChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAdChars]];
                            
                        }
                    }
                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                        
                    }
                }
            } else {
             
//                BOOL executeQueryResults = sqlite3_step(compiledStatement);
//                
//                if (executeQueryResults == SQLITE_DONE) {
                
                            
                if (sqlite3_step(compiledStatement)) {
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                } else {
                    
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                    
                    
                    
                }
            }
        }
        else {
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        sqlite3_finalize(compiledStatement);
        
    }
    sqlite3_close(sqlite3Database);
    
}



-(NSArray *)loadDataFromDB:(NSString *)query {
    
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    return (NSArray *)self.arrResults;
}



-(void)executeQuery:(NSString *)query{
    // Run the query and indicate that is executable.
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}



-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename {
    
    self = [super init];
    if (self) {
        // Set the documents directory path to the documentsDirectory propery
        
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [path objectAtIndex:0];
        
        // Keep the database filename
        self.databaseFilename = dbFilename;
        
        // Copy the database file into the documents directory
        [self copyDatabaseIntoDocumentsDirectory];
    
        
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory {
    
    
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        
        
    }
   

    
    
    
    
}
    
 



@end
