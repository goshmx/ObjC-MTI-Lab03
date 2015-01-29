//
//  DBManager.m
//  Agenda
//
//  Created by TRON on 29/01/15.
//  Copyright (c) 2015 TRON. All rights reserved.
//

#import "DBManager.h"

//Inicializar valores
NSString *dbname = @"gamepush2.db";
const char *createStatment = "create table if not exists pushresults (pushid integer primary key AUTOINCREMENT, score integer, fechahora text)";

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager
+(DBManager*)getSharedInstance{
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance crearDB];
    }
    return sharedInstance;
}

/*!
 * @brief Funcion para crear la base de datos.
 * @return YES/NO si la base de datos se creo exitosamente.
 */
-(BOOL)crearDB{
    NSString *docsDir;
    NSArray *dirPaths;
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: dbname]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO){
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK){
            char *errMsg;
            if (sqlite3_exec(database, createStatment, NULL, NULL, &errMsg) != SQLITE_OK){
                isSuccess = NO;
                NSLog(@"Error al crear la tabla");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Error al abrir/crear la base de datos");
        }
    }
    return isSuccess;
}


/*!
 * @brief Funcion para insertar un querystring en la base de datos.
 * @param query cadena con el insert SQL para ejecutar.
 * @return YES/NO si el insert se ejecuto exitosamente.
 * @code NSString *insertSQL = [NSString stringWithFormat:@"insert into pushresults (score,fechahora) values (\"%d\",\"%@\" )",score, fechahora];
 */
- (BOOL) saveDB:(NSString*)query;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        const char *insert_stmt = [query UTF8String];
        sqlite3_prepare_v2(database, insert_stmt,-1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE){
            sqlite3_reset(statement);
            NSLog(@"Registro Insertado");
            return YES;
        } else {
            NSLog(@"Registro FALLO (%s)", sqlite3_errmsg(database));
            sqlite3_reset(statement);
            return NO;
        }
    }
    return NO;
}

/*!
 * @brief Funcion para consultar mediante un querystring en la base de datos.
 * @param query cadena con el query SQL para ejecutar.
 * @return ar_result Arreglo con los datos de la consulta.
 * @code NSString *querySQL = [NSString stringWithFormat: @"select score, fechahora from pushresults order by score DESC"];
 */
- (NSMutableArray*) listDB:(NSString*)query;
{
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        const char *query_stmt = [query UTF8String];
        NSMutableArray *ar_result = [[NSMutableArray alloc] initWithCapacity:10];
        if (sqlite3_prepare_v2(database,query_stmt, -1, &statement, NULL) == SQLITE_OK){
            int columns = sqlite3_column_count(statement);
            while (sqlite3_step(statement) == SQLITE_ROW){
                NSMutableArray *arc = [[NSMutableArray alloc] initWithCapacity:columns];
                for(int i=0; i < columns; i++){
                    if (sqlite3_column_text(statement, i) == NULL)
                        [arc addObject:@""];
                    else
                        [arc addObject:[NSString stringWithCString:(char *)sqlite3_column_text(statement, i)
                                                          encoding:NSUTF8StringEncoding]
                         ];
                }
                [ar_result addObject:arc];
            }
            sqlite3_reset(statement);
            return ar_result;
        }
    }
    return nil;
}

@end
