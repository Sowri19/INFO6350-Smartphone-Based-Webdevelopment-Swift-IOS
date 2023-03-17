import Foundation

class Product_Post {
    var dictionary: [String: Any]

    var product_post_id: Int {
        get { return dictionary["product_post_id"] as? Int ?? 0 }
        set { dictionary["product_post_id"] = newValue }
    }

    var product_type_id: Int {
        get { return dictionary["product_type_id"] as? Int ?? 0 }
        set { dictionary["product_type_id"] = newValue }
    }

    var company_id: Int {
        get { return dictionary["company_id"] as? Int ?? 0 }
        set { dictionary["company_id"] = newValue }
    }

    var product_id: Int {
        get { return dictionary["product_id"] as? Int ?? 0 }
        set { dictionary["product_id"] = newValue }
    }

    var posted_date: Date {
        get { return dictionary["posted_date"] as? Date ?? Date() }
        set { dictionary["posted_date"] = newValue }
    }
    var price: Double {
        get { return dictionary["price"] as? Double ?? 0 }
        set { dictionary["price"] = newValue }
    }

    var description: String {
        get { return dictionary["description"] as? String ?? "" }
        set { dictionary["description"] = newValue }
    }
    init(product_post_id: Int, product_type_id: Int, company_id: Int, product_id: Int, posted_date: Date, price: Double, description: String) {
        self.dictionary = [
                "product_post_id": product_post_id,
                "product_type_id": product_type_id,
                "company_id": company_id,
                "product_id": product_id,
                "posted_date": posted_date,
                "price": price,
                "description": description
            ]
    }
}

