//
//  Person+CoreDataProperties.swift
//  
//
//  Created by Chen Wei Wen on 18/11/2019.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64

}
