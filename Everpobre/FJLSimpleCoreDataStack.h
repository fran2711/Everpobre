//
//  AGTSimpleCoreDataStack.h
//  everpobre
//
//  Created by Fernando Rodríguez Romero on 12/12/13.
//  Copyright (c) 2013 Agbo. All rights reserved.
//

@import CoreData;

#import <Foundation/Foundation.h>

@interface FJLSimpleCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+ (NSString *)persistentStoreCoordinatorErrorNotificationName;

+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName
                          databaseFilename:(NSString *)aDBName;

//Crea un fichero de SQLLite y lo guarda con el mismo nombre que tenga el modelo y lo guarda dentro de la carpeta documents
+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName;

+ (instancetype)coreDataStackWithModelName:(NSString *)aModelName
                               databaseURL:(NSURL *)aDBURL;


//Inicializador designado
- (id)initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL *)aDBURL;

//Elimina la base de datos
- (void)zapAllData;

//Lo que hacen estos dos bloques es aceptar como parametro un bloque de error y guardarlo si se comete algun error
- (void)saveWithErrorBlock: (void(^)(NSError *error))errorBlock;
- (NSArray *)executeRequest: (NSFetchRequest *)request
                  withError: (void(^)(NSError *error))errorBlock;


@end
