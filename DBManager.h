//
//  DBManager.h
//  Agenda
//
//  Created by TRON on 29/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;

-(BOOL)crearDB;
-(BOOL)saveDB:(NSString*)query;
-(NSMutableArray*)listDB:(NSString*)query;

@end
