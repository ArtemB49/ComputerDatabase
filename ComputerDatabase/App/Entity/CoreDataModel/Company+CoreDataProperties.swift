//
//  Company+CoreDataProperties.swift
//  ComputerDatabase
//
//  Created by Артем Б on 28.08.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var companyID: Int16
    @NSManaged public var name: String?

}
