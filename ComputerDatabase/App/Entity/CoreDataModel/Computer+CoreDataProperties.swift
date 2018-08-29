//
//  Computer+CoreDataProperties.swift
//  ComputerDatabase
//
//  Created by Артем Б on 28.08.2018.
//  Copyright © 2018 Артем Б. All rights reserved.
//
//

import Foundation
import CoreData


extension Computer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Computer> {
        return NSFetchRequest<Computer>(entityName: "Computer")
    }

    @NSManaged public var computerID: Int16
    @NSManaged public var descriptionComputer: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var introduced: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var discounted: NSDate?
    @NSManaged public var company: Company?

}
