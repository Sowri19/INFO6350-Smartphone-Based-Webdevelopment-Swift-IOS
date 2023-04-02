class Product_type {
    var dictionary: [String: Any]
    
    var id: Int {
        get { return dictionary["id"] as? Int ?? 0 }
        set { dictionary["id"] = newValue }
    }
    
    var product_type: String {
        get { return dictionary["product_type"] as? String ?? "" }
        set { dictionary["product_type"] = newValue }
    }
    
    init(id: Int, product_type: String ) {
        self.dictionary = [
            "id": id,
            "product_type": product_type,
        ]
    }
}
