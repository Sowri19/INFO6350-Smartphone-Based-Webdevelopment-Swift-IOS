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

func addProductTypeFromUserInput() {
    // Get the product type ID from the user
    print("Enter the ID of the product type:")
    guard let idString = readLine(), let id = Int(idString) else {
        print("Invalid input. Please enter a valid integer for the ID.")
        return
    }
    
    // Get the product type name from the user
    print("Enter the name of the product type:")
    guard let productType = readLine(), !productType.isEmpty else {
        print("Invalid input. Please try again.")
        return
    }
    
    // Create a new Product_type object
    let newProductType = Product_type(id: id, product_type: productType)
    
    // Add the new product type to the productTypes array
    productManager.productTypes.append(newProductType)
    
    // Print a success message
    print("Product type added successfully!")
}

func deleteProductTypeFromUserInput() {
    print("Enter the ID of the product type to delete:")
    if let input = readLine(), let id = Int(input) {
        // Check if a product type with the input ID exists
        if let productType = productManager.productTypes.first(where: { $0.id == id }) {
            // Remove the product type from the productTypes array
            productManager.productTypes.removeAll(where: { $0.id == id })
            print("Product type '\(productType.product_type)' (ID: \(id)) deleted successfully!")
        } else {
            print("Unable to delete product type. Invalid ID.")
        }
    } else {
        print("Invalid input. Please enter a valid ID.")
    }
}
