//
//  DBManager.h
//  Agenda
//
//  Created by TRON on 29/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

extern NSString *idSelect;

@interface DBManager : NSObject
{
    NSString *databasePath;
}

+(DBManager*)getSharedInstance;

-(BOOL)crearDB;
-(BOOL)saveDB:(NSString*)query;
-(NSMutableArray*)listDB:(NSString*)query;
-(NSMutableArray*)consultaDB:(NSString*)query;
-(BOOL)insertaDB:(NSString*)nombre estado:(NSString*)estado youtube:(NSString*)youtube foto:(NSData*)foto;
-(BOOL)actualizaDB:(NSString*)nombre estado:(NSString*)estado youtube:(NSString*)youtube foto:(NSData*)foto idagenda:(NSString*)idagenda;
-(NSMutableArray*) executeQueryWithString:(NSString*)querySQL;

@end
