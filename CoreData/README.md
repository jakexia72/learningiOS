# Persisting Data with Core Data

### Objective
* To be able to persist data
* To build the layers and classes needed - "Core Data stack"

### Notes

#### [NSManagedObjectModel](https://developer.apple.com/documentation/coredata/nsmanagedobjectmodel)
- usually created with the data modeling tool 
- provides mapping between entity objects and corresponding managed object class 
- This is where you make fetch requests

#### [NSManagedObjectContext](https://developer.apple.com/documentation/coredata/nsmanagedobjectcontext)
- responsible for watching for changes in its objects and maintains an undo manager
- Kind of like the buffer where objects are held until comitted to memory 

#### [NSPersistentStoreCoordinator](https://developer.apple.com/documentation/coredata/nspersistentstorecoordinator)
- A coordinator that uses the model to help contexts and persistent stores communicate

#### [NSPersistentContainer](https://developer.apple.com/documentation/coredata/nspersistentcontainer)
- A container that encapsulates the Core Data stack to make it easier to manage


