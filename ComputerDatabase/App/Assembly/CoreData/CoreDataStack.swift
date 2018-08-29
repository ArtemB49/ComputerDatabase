/**
 * Синглтон для работы с CoreData
 */

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Init
    private(set) static var shared: CoreDataStack = {
        return CoreDataStack()
    }()
    
    init(modelName: String = "ComputerDatabase", storeName: String = "ComputerDatabase.sqlite") {
        self.modelName = modelName
        self.storeName = storeName
        registerStore()
    }
    
    
    // MARK: - Private properties
    private let storeIsReady = DispatchGroup()
    private let modelName: String
    private let storeName: String
    
    
    // MARK: - Public properties
    lazy var mainContext: NSManagedObjectContext = {
        storeIsReady.wait()
        
        return DispatchQueue.anywayOnMain {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
            context.persistentStoreCoordinator = coordinator
            return context
        }
    }()
    
    // MARK: - Public methods
    func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()
        
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        return context
    }
    
    func saveToStore() {
        storeIsReady.wait()
        
        DispatchQueue.anywayOnMain {
            guard mainContext.hasChanges else {
                debugPrint("Data has not changes")
                return
            }
            do {
                try mainContext.save()
                debugPrint("Data succesfully saved to store")
            } catch {
                debugPrint("Data not saved to store with error \(error)")
            }
        }
    }
    
    // MARK: - Private methods
    private lazy var coordinator: NSPersistentStoreCoordinator = {
        NSPersistentStoreCoordinator(managedObjectModel: objectModel)
    }()
    
    private lazy var objectModel: NSManagedObjectModel = {
        guard let model = NSManagedObjectModel(contentsOf: objectModelUrl) else {
            fatalError("Error initializing mom from: \(modelName)")
        }
        return model
    }()
    
    private lazy var objectModelUrl: URL = {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        return url
    }()
    
    private lazy var documentsUrl: URL = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        
        return url
    }()
    
    
    private func registerStore() {
        storeIsReady.enter()
        
        DispatchQueue.global(qos: .background).async {
            let storeUrl = self.documentsUrl.appendingPathComponent(self.storeName)
            
            do {
                try self.coordinator.addPersistentStore(
                    ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: storeUrl,
                    options: nil)
                
                self.storeIsReady.leave()
            } catch {
                fatalError("Error create store: \(error)")
            }
        }
    }
}
