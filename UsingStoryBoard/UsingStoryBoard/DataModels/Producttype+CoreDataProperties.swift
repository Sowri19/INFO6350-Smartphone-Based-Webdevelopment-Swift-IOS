//
//  Producttype+CoreDataProperties.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/6/23.
//
//

import Foundation
import CoreData


extension Producttype {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producttype> {
        return NSFetchRequest<Producttype>(entityName: "Producttype")
    }

    @NSManaged public var id: Int64
    @NSManaged public var product_type: String?

}

extension Producttype : Identifiable {

}
