/**
 * CoreData Класс компьютера
 */

import Foundation
import CoreData

@objc(Computer)
public class Computer: NSManagedObject {
    static func makeOrUpdate(computerCodable: ComputerResult, in context: NSManagedObjectContext) -> Computer? {
        
        let object = Computer(entity: entity(), insertInto: context)
        
        object.computerID = Int16(computerCodable.computerID)
        object.name = computerCodable.name
        object.descriptionComputer = computerCodable.description
        object.imageUrl = computerCodable.imageUrl?.absoluteString
        object.introduced = computerCodable.introduced as NSDate?
        object.discounted = computerCodable.discounted as NSDate?
        if let companyResult = computerCodable.company {
            object.company = Company.makeOrUpdate(companyCodable: companyResult, in: context)
        }
        
        debugPrint("Object created: \(type(of: self)) \(computerCodable.computerID)")
        
        return object
    }
}
