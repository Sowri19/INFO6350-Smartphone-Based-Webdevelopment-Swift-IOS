//
//  product.swift
//  EmptyApp
//
//  Copyright © 2023 rab. All rights reserved.
//
import UIKit

class Product {
    var dictionary: [String: Any]
    
    var id: Int {
        get { return dictionary["id"] as? Int ?? 0 }
        set { dictionary["id"] = newValue }
    }
    
    var name: String {
        get { return dictionary["name"] as? String ?? "" }
        set { dictionary["name"] = newValue }
    }
    
    var product_description: String {
        get { return dictionary["product_description"] as? String ?? "" }
        set { dictionary["product_description"] = newValue }
    }
    
    var product_rating: Double {
        get { return dictionary["product_rating"] as? Double ?? 0 }
        set { dictionary["product_rating"] = newValue }
    }
    
    var company_id: Int {
        get { return dictionary["company_id"] as? Int ?? 0 }
        set { dictionary["company_id"] = newValue }
    }
    
    var quantity: Int {
        get { return dictionary["quantity"] as? Int ?? 0 }
        set { dictionary["quantity"] = newValue }
    }
    
    init(id: Int, name: String, product_description: String, product_rating: Double, company_id: Int, quantity: Int) {
        self.dictionary = [
            "id": id,
            "name": name,
            "product_description": product_description,
            "product_rating": product_rating,
            "company_id": company_id,
            "quantity": quantity
        ]
    }
}
