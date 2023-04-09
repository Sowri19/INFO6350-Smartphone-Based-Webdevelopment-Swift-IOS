//
//  OrdersData+CoreDataProperties.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//
//

import Foundation
import CoreData


extension OrdersData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OrdersData> {
        return NSFetchRequest<OrdersData>(entityName: "OrdersData")
    }

    @NSManaged public var post_id: Int64
    @NSManaged public var product_id: Int64
    @NSManaged public var date: Date?
    @NSManaged public var product_type: String?
    @NSManaged public var order_id: Int64

}

extension OrdersData : Identifiable {

}
