#import "FJLNamedEntity.h"

@interface FJLNamedEntity ()

// Private interface goes here.

+(NSArray *) observableKeyNames;


@end

@implementation FJLNamedEntity


#pragma mark - Class methods
+(NSArray *)observableKeyNames{
    return @[@"name", @"creationDate"];
}

#pragma mark - KVO
-(void) setupKVO{
    
    
    for (NSString *key in [[self class] observableKeyNames]) {
        
        [self addObserver:self
               forKeyPath:key
                  options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                  context:NULL];
    }
}

-(void) tearDownKVO{
    
    for (NSString *key  in [[self class] observableKeyNames]) {
        [self removeObserver:self
                  forKeyPath:key];
    }
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    self.modificationDate = [NSDate date];
    
}

#pragma mark - LifeCycle
-(void) awakeFromInsert{
    
    [super awakeFromInsert];
    [self setupKVO];
    
}

-(void) awakeFromFetch{
    [super awakeFromFetch];
    [self setupKVO];
}


-(void) willTurnIntoFault{
    [super willTurnIntoFault];
    
    [self tearDownKVO];
    
}


@end
