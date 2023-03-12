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

func addProductPostFromUserInput() {
    // Prompt the user for the product post ID
    print("Enter the ID for this product post:")
    guard let id = readLine().flatMap(Int.init) else {
        print("Invalid ID")
        return
    }
    
    // Get product type ID from user input
    print("Enter the ID of the product type for this post:")
    guard let product_type_id = readLine().flatMap(Int.init) else {
        print("Invalid input")
        return
    }
    
    // Get company ID from user input
    print("Enter the ID of the company for this post:")
    guard let company_id = readLine().flatMap(Int.init) else {
        print("Invalid input")
        return
    }
    
    // Get product ID from user input
    print("Enter the ID of the product for this post:")
    guard let product_id = readLine().flatMap(Int.init) else {
        print("Invalid input")
        return
    }
    
    // Get posted date from user input
    print("Enter the posted date for this post (yyyy-MM-dd):")
    guard let posted_date_string = readLine() else {
        print("Invalid input")
        return
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    guard let posted_date = formatter.date(from: posted_date_string) else {
        print("Invalid date format")
        return
    }
    
    // Get price from user input
    print("Enter the price for this post:")
    guard let price = readLine().flatMap(Double.init) else {
        print("Invalid input")
        return
    }
    
    // Get description from user input
    print("Enter the description for this post:")
    guard let description = readLine() else {
        print("Invalid input")
        return
    }
    if productManager.companies.contains(where: { $0.id == company_id }) && productManager.productTypes.contains(where: { $0.id == product_type_id }) && productManager.products.contains(where: { $0.id == product_id }){
    // Create the product post object and add it to the product post manager
    let productPost = Product_Post(product_post_id: id, product_type_id: product_type_id, company_id: company_id, product_id: product_id, posted_date: posted_date, price: price, description: description)
        productManager.addProductPost(productPost: productPost)
    } else if !productManager.companies.contains(where: { $0.id == company_id }) {
        print("Invalid company ID")
        return
    } else if !productManager.productTypes.contains(where: { $0.id == product_type_id }) {
        print("Invalid product type ID")
        return
    } else if !productManager.products.contains(where: { $0.id == product_id }) {
        print("Invalid product ID")
        return
    }
}

func updateProductPostFromUserInput() {
    // Get product post ID from user input
    print("Enter the ID of the product post you want to update:")
    guard let productPostID = readLine(),
          let productPostIDInt = Int(productPostID) else {
        print("Invalid product post ID.")
        return
    }

    // Find the product post in the productPosts array
    guard let productPost = productManager.productPosts.first(where: { $0.product_post_id == productPostIDInt }) else {
        print("Product post not found.")
        return
    }

    // Get updated information from user input
    print("Enter the updated product ID:")
    guard let productID = readLine(),
          let productIDInt = Int(productID) else {
        print("Invalid product ID.")
        return
    }
    productPost.product_id = productIDInt

    print("Enter the updated company ID:")
    guard let companyID = readLine(),
          let companyIDInt = Int(companyID) else {
        print("Invalid company ID.")
        return
    }
    productPost.company_id = companyIDInt
    
    print("Enter the updated product type ID:")
    guard let productTypeID = readLine(),
          let productTypeIDInt = Int(productTypeID) else {
        print("Invalid product type ID.")
        return
    }
    productPost.product_type_id = productTypeIDInt

    print("Enter the updated description:")
    if let description = readLine() {
        productPost.description = description
    }

    print("Enter the updated price:")
    if let price = readLine(),
       let priceDouble = Double(price) {
        productPost.price = priceDouble
    }
    
    print("Enter the updated posted date (yyyy-MM-dd):")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    if let dateString = readLine(), let date = dateFormatter.date(from: dateString) {
        productPost.posted_date = date
    }
    
    if productManager.companies.contains(where: { $0.id == companyIDInt }) && productManager.productTypes.contains(where: { $0.id == productTypeIDInt }) && productManager.products.contains(where: { $0.id == productIDInt }){
            // Update the product post in the productPosts array
            productManager.updateProductPost(productPost: productPost)
        } else if !productManager.companies.contains(where: { $0.id == companyIDInt }) {
            print("Invalid company ID")
            return
        } else if !productManager.productTypes.contains(where: { $0.id == productTypeIDInt }) {
            print("Invalid product type ID")
            return
        } else if !productManager.products.contains(where: { $0.id == productIDInt }) {
            print("Invalid product ID")
            return
        }
}
    
func deleteProductPostFromUserInput() {
    print("Enter the ID of the product post you want to delete:")
    if let id = readLine(), let productPostId = Int(id) {
        // Find the product post with the given ID
        if let productPost = productManager.productPosts.first(where: { $0.product_post_id == productPostId }) {
            // Delete the product post
            productManager.deleteProductPost(productPost: productPost)
        } else {
            print("Product post not found. Invalid ID.")
        }
    } else {
        print("Invalid input. Please enter a valid ID.")
    }
}
