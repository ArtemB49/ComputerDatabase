/**
 * Синглтон проверяющий наличие запрашиваемого компьютера
 * в CoreData, если не находит то делает запрос на сервер
 */

import Foundation
import CoreData


final class ComputerRepository {
    private let storage: CoreDataStack
    private let requestFactory: ComputersRequestFactory
    
    static let shared: ComputerRepository = {
        return ComputerRepository(
            storage: CoreDataStack.shared,
            requestFactory: RequestFactory().makeComputersRequestFactory()
        )
    }()
    
    init(storage: CoreDataStack, requestFactory: ComputersRequestFactory) {
        self.storage = storage
        self.requestFactory = requestFactory
    }
    
    func fetchComputer(computerID: Int16, completionHandler: @escaping (Computer) -> ()) {
        let context = storage.makePrivateContext()
        
        context.perform {
            do {
                let request: NSFetchRequest<Computer> = Computer.fetchRequest()
                request.predicate = NSPredicate(format: "computerID = %i", computerID)
                
                var computer = try request.execute().first
                
                if computer == nil {
                    self.requestFactory.getComputer(computerID: Int(computerID)) { response in
                        switch response.result {
                        case .success(let computerResult):
                            computer = Computer.makeOrUpdate(computerCodable: computerResult, in: context)
                            try! context.save()
                            try! self.storage.mainContext.save()
                            guard let unwrappedComputer = computer else { return }
                            completionHandler(unwrappedComputer)
                        case .failure(_):
                            debugPrint("Can't fetch people with id \(computerID)")
                        }
                    }
                } else {
                    try context.save()
                    try self.storage.mainContext.save()
                    guard let unwrappedComputer = computer else { return }
                    completionHandler(unwrappedComputer)
                }
            }
            catch {
                debugPrint("Can't fetch people with id \(computerID)")
            }
        }
    }
}
