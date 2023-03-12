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

func addProductFromUserInput() {
    print("Enter the details for the new product:")
    
    // Get the ID
    print("ID:")
    guard let id = readLine().flatMap(Int.init) else {
        print("Invalid ID")
        return
    }
    
    // Get the name
    print("Name:")
    guard let name = readLine() else {
        print("Invalid name")
        return
    }
    
    // Get the product description
    print("Product description:")
    guard let description = readLine() else {
        print("Invalid product description")
        return
    }
    
    // Get the product rating
    print("Product rating:")
    guard let rating = readLine().flatMap(Double.init),(1...5).contains(rating) else {
        print("Invalid product rating, enter rating between 1 and 5")
        return
    }
    
    // Get the company ID
    print("Company ID:")
    guard let companyID = readLine().flatMap(Int.init) else {
        print("Invalid company ID")
        return
    }
    
    // Get the quantity
    print("Quantity:")
    guard let quantity = readLine().flatMap(Int.init) else {
        print("Invalid quantity")
        return
    }
    if productManager.companies.contains(where: { $0.id == companyID }) {
    // Create the product
    let product = Product(id: id, name: name, product_description: description, product_rating: rating, company_id: companyID, quantity: quantity)
    
    // Add the product to the product manager
    productManager.addProduct(product: product)
    } else {
        print("Invalid company ID")
        return
    }
}
