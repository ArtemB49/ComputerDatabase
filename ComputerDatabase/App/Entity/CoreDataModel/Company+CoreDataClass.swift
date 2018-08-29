/**
 * CoreData Класс компании
 */

import Foundation
import CoreData

@objc(Company)
public class Company: NSManagedObject {

    static func makeOrUpdate(companyCodable: CompanyResult, in context: NSManagedObjectContext) -> Company? {
        
        let object = Company(entity: entity(), insertInto: context)
        
        object.companyID = Int16(companyCodable.companyID)
        object.name = companyCodable.name
        
        debugPrint("Object created: \(type(of: self)) \(companyCodable.companyID)")
        
        return object
    }
    
}
