//
//  Producttype+CoreDataProperties.swift
//  Using Interface Builder
//
//  Created by Sowri on 4/1/23.
//
//

import Foundation
import CoreData


extension Producttype {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producttype> {
        return NSFetchRequest<Producttype>(entityName: "Producttype")
    }

    @NSManaged public var product_type: String?
    @NSManaged public var id: Int64

}

extension Producttype : Identifiable {

}
