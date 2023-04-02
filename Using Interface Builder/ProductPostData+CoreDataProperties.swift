//
//  ProductPostData+CoreDataProperties.swift
//  Using Interface Builder
//
//  Created by Sowri on 4/2/23.
//
//

import Foundation
import CoreData


extension ProductPostData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductPostData> {
        return NSFetchRequest<ProductPostData>(entityName: "ProductPostData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var product_type_id: Int64
    @NSManaged public var company_id: Int64
    @NSManaged public var product_id: Int64
    @NSManaged public var posted_date: Date?
    @NSManaged public var price: Double
    @NSManaged public var description_: String?

}

extension ProductPostData : Identifiable {

}
