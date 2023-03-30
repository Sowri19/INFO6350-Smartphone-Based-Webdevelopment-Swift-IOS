//
//  order.swift
//  EmptyApp
//
//  Created by Sowri on 3/19/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation
import UIKit

class Order {
    var dictionary: [String: Any]
    
    var order_id: Int {
        get { return dictionary["order_id"] as? Int ?? 0 }
        set { dictionary["order_id"] = newValue }
    }
    
    var post_id: Int {
        get { return dictionary["post_id"] as? Int ?? 0 }
        set { dictionary["post_id"] = newValue }
    }
    
    var date: Date {
        get { return dictionary["date"] as? Date ?? Date() }
        set { dictionary["date"] = newValue }
    }
    
    var product_id: Int {
        get { return dictionary["product_id"] as? Int ?? 0 }
        set { dictionary["product_id"] = newValue }
    }
    
    var product_type: String {
        get { return dictionary["product_type"] as? String ?? "" }
        set { dictionary["product_type"] = newValue }
    }
    
    init(order_id: Int, post_id: Int, date: Date, product_id: Int, product_type: String) {
        self.dictionary = [
            "order_id": order_id,
            "post_id": post_id,
            "date": date,
            "product_id": product_id,
            "product_type": product_type
        ]
    }
}
