//
//  ProductData+CoreDataProperties.swift
//  Using Interface Builder
//
//  Created by Sowri on 4/1/23.
//
//

import Foundation
import CoreData


extension ProductData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductData> {
        return NSFetchRequest<ProductData>(entityName: "ProductData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var product_description: String?
    @NSManaged public var product_rating: Double
    @NSManaged public var company_id: Int64
    @NSManaged public var quantity: Int64

}

extension ProductData : Identifiable {

}
