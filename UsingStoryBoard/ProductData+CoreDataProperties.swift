//
//  ProductData+CoreDataProperties.swift
//  UsingStoryBoard
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
    @NSManaged public var quantity: Int64
    @NSManaged public var company_id: Int64
    @NSManaged public var logo: Data?

}

extension ProductData : Identifiable {

}
