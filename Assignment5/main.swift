//
//  main.swift
//  Assignment5
//
//  Created by Sowri on 2/26/23.
//

import Foundation

//class Company {
//    var dictionary: [String: Any]
//
//    var id: Int {
//        get { return dictionary["id"] as? Int ?? 0 }
//        set { dictionary["id"] = newValue }
//    }
//
//    var name: String {
//        get { return dictionary["name"] as? String ?? "" }
//        set { dictionary["name"] = newValue }
//    }
//
//    var address: String {
//        get { return dictionary["address"] as? String ?? "" }
//        set { dictionary["address"] = newValue }
//    }
//
//    var country: String {
//        get { return dictionary["country"] as? String ?? "" }
//        set { dictionary["country"] = newValue }
//    }
//
//    var zip: String {
//        get { return dictionary["zip"] as? String ?? "" }
//        set { dictionary["zip"] = newValue }
//    }
//
//    init(id: Int, name: String, address: String, country: String, zip: String) {
//        self.dictionary = [
//            "id": id,
//            "name": name,
//            "address": address,
//            "country": country,
//            "zip": zip
//        ]
//    }
//}

//class Product {
//    var dictionary: [String: Any]
//
//    var id: Int {
//        get { return dictionary["id"] as? Int ?? 0 }
//        set { dictionary["id"] = newValue }
//    }
//
//    var name: String {
//        get { return dictionary["name"] as? String ?? "" }
//        set { dictionary["name"] = newValue }
//    }
//
//    var product_description: String {
//        get { return dictionary["product_description"] as? String ?? "" }
//        set { dictionary["product_description"] = newValue }
//    }
//
//    var product_rating: Double {
//        get { return dictionary["product_rating"] as? Double ?? 0 }
//        set { dictionary["product_rating"] = newValue }
//    }
//
//    var company_id: Int {
//        get { return dictionary["companyId"] as? Int ?? 0 }
//        set { dictionary["companyId"] = newValue }
//    }
//
//    var quantity: Int {
//        get { return dictionary["quantity"] as? Int ?? 0 }
//        set { dictionary["quantity"] = newValue }
//    }
//
//    init(id: Int, name: String, product_description: String, product_rating: Double, company_id: Int, quantity: Int) {
//        self.dictionary = [
//            "id": id,
//            "name": name,
//            "product_description": product_description,
//            "product_rating": product_rating,
//            "company_id": company_id,
//            "quantity": quantity
//        ]
//    }
//}

//class Product_Post {
//    var dictionary: [String: Any]
//
//    var product_post_id: Int {
//        get { return dictionary["product_post_id"] as? Int ?? 0 }
//        set { dictionary["product_post_id"] = newValue }
//    }
//
//    var product_type_id: Int {
//        get { return dictionary["product_type_id"] as? Int ?? 0 }
//        set { dictionary["product_type_id"] = newValue }
//    }
//
//    var company_id: Int {
//        get { return dictionary["company_id"] as? Int ?? 0 }
//        set { dictionary["company_id"] = newValue }
//    }
//
//    var product_id: Int {
//        get { return dictionary["product_id"] as? Int ?? 0 }
//        set { dictionary["product_id"] = newValue }
//    }
//
//    var posted_date: Date {
//        get { return dictionary["posted_date"] as? Date ?? Date() }
//        set { dictionary["posted_date"] = newValue }
//    }
//    var price: Double {
//        get { return dictionary["price"] as? Double ?? 0 }
//        set { dictionary["price"] = newValue }
//    }
//
//    var description: String {
//        get { return dictionary["description"] as? String ?? "" }
//        set { dictionary["description"] = newValue }
//    }
//    init(product_post_id: Int, product_type_id: Int, company_id: Int, product_id: Int, posted_date: Date, price: Double, description: String) {
//        self.dictionary = [
//                "product_post_id": product_post_id,
//                "product_type_id": product_type_id,
//                "company_id": company_id,
//                "product_id": product_id,
//                "posted_date": posted_date,
//                "price": price,
//                "description": description
//            ]
//    }
//}

//class Product_type {
//    var dictionary: [String: Any]
//
//    var id: Int {
//        get { return dictionary["id"] as? Int ?? 0 }
//        set { dictionary["id"] = newValue }
//    }
//
//    var product_type: String {
//        get { return dictionary["product_type"] as? String ?? "" }
//        set { dictionary["product_type"] = newValue }
//    }
//
//    init(id: Int, product_type: String ) {
//        self.dictionary = [
//            "id": id,
//            "product_type": product_type,
//        ]
//    }
//}

// Create a ProductManager instance
let productManager = ProductManager()

class ProductManager {
        
        var products: [Product] = []
        var companies: [Company] = []
        var productPosts: [Product_Post] = []
        var productTypes: [Product_type] = []
        
        // Add a product
        func addProduct(product: Product) {
            products.append(product)
            print("Product added successfully!")
        }
    
        // Add a company
        func addCompany(company: Company) {
            companies.append(company)
        }
    
        // Delete a company
        func deleteCompany(company: Company) {
            // Remove the company from the companies array
            if let index = companies.firstIndex(where: { $0.id == company.id }) {
                companies.remove(at: index)
                // Remove any product posts associated with the company
                productPosts.removeAll(where: { $0.company_id == company.id })
                print("Company deleted successfully!")
            } else {
                print("Unable to delete company. Invalid ID.")
            }
        }
        // View all companies
        func viewAllCompanies() -> [Company] {
            return companies
        }

        // Add a product type
        func addProductType(productType: Product_type) {
            productTypes.append(productType)
        }
        
        func deleteProductType(productType: Product_type) {
            // Remove the product type from the productTypes array
            if let index = productTypes.firstIndex(where: { $0.id == productType.id }) {
                productTypes.remove(at: index)
                print("Product type deleted successfully!")
            } else {
                print("Unable to delete product type. Invalid ID.")
            }
        }
        // Add a product post
        func addProductPost(productPost: Product_Post) {
            productPosts.append(productPost)
            print("Product post added successfully!")
        }
        // Delete a product post
           func deleteProductPost(productPost: Product_Post) {
               // Remove the product post from the productPosts array
               if let index = productPosts.firstIndex(where: { $0.product_post_id == productPost.product_post_id }) {
                   productPosts.remove(at: index)
                   print("Product post deleted successfully!")
               } else {
                   print("Unable to delete product post. Invalid ID.")
               }
           }
        // Update a product post
        func updateProductPost(productPost: Product_Post) {
            // Find the product post in the productPosts array
            if let index = productPosts.firstIndex(where: { $0.product_post_id == productPost.product_post_id }) {
                // Update the product post
                productPosts[index] = productPost
                print("Product post updated successfully!")
            } else {
                print("Unable to update product post. Invalid ID.")
            }
        }
        // View all product types
        func viewAllProductTypes() -> [Product_type] {
            return productTypes
        }

        // View all products
        func viewAllProducts() -> [Product] {
            return products
        }
        // View all product posts
        func viewAllProductPosts() -> [Product_Post] {
            return productPosts
        }
}

//func addProductFromUserInput() {
//    print("Enter the details for the new product:")
//
//    // Get the ID
//    print("ID:")
//    guard let id = readLine().flatMap(Int.init) else {
//        print("Invalid ID")
//        return
//    }
//
//    // Get the name
//    print("Name:")
//    guard let name = readLine() else {
//        print("Invalid name")
//        return
//    }
//
//    // Get the product description
//    print("Product description:")
//    guard let description = readLine() else {
//        print("Invalid product description")
//        return
//    }
//
//    // Get the product rating
//    print("Product rating:")
//    guard let rating = readLine().flatMap(Double.init),(1...5).contains(rating) else {
//        print("Invalid product rating, enter rating between 1 and 5")
//        return
//    }
//
//    // Get the company ID
//    print("Company ID:")
//    guard let companyID = readLine().flatMap(Int.init) else {
//        print("Invalid company ID")
//        return
//    }
//
//    // Get the quantity
//    print("Quantity:")
//    guard let quantity = readLine().flatMap(Int.init) else {
//        print("Invalid quantity")
//        return
//    }
//    if productManager.companies.contains(where: { $0.id == companyID }) {
//    // Create the product
//    let product = Product(id: id, name: name, product_description: description, product_rating: rating, company_id: companyID, quantity: quantity)
//
//    // Add the product to the product manager
//    productManager.addProduct(product: product)
//    } else {
//        print("Invalid company ID")
//        return
//    }
//}

//func addCompanyFromUserInput() {
//    print("Enter company ID:")
//    guard let idString = readLine(),
//        let id = Int(idString),
//        id > 0 else {
//            print("Invalid input for company ID")
//            return
//    }
//
//    print("Enter company name:")
//    guard let name = readLine(), !name.isEmpty else {
//        print("Invalid input for company name")
//        return
//    }
//
//    print("Enter company address:")
//    guard let address = readLine(), !address.isEmpty else {
//        print("Invalid input for company address")
//        return
//    }
//
//    print("Enter company country:")
//    guard let country = readLine(), !country.isEmpty else {
//        print("Invalid input for company country")
//        return
//    }
//
//    print("Enter company zip:")
//    guard let zip = readLine(), !zip.isEmpty else {
//        print("Invalid input for company zip")
//        return
//    }
//
//    let company = Company(id: id, name: name, address: address, country: country, zip: zip)
//    productManager.addCompany(company: company)
//
//    print("Company added successfully!")
//}

//func deleteCompanyFromUserInput() {
//    print("Enter the ID of the company you want to delete:")
//    if let companyID = readLine(),
//       let id = Int(companyID),
//       let company = productManager.companies.first(where: { $0.id == id }) {
//        productManager.deleteCompany(company: company)
//    } else {
//        print("Invalid company ID. Please try again.")
//    }
//}

//func addProductTypeFromUserInput() {
//    // Get the product type ID from the user
//    print("Enter the ID of the product type:")
//    guard let idString = readLine(), let id = Int(idString) else {
//        print("Invalid input. Please enter a valid integer for the ID.")
//        return
//    }
//
//    // Get the product type name from the user
//    print("Enter the name of the product type:")
//    guard let productType = readLine(), !productType.isEmpty else {
//        print("Invalid input. Please try again.")
//        return
//    }
//
//    // Create a new Product_type object
//    let newProductType = Product_type(id: id, product_type: productType)
//
//    // Add the new product type to the productTypes array
//    productManager.productTypes.append(newProductType)
//
//    // Print a success message
//    print("Product type added successfully!")
//}

// Delete a product type
//func deleteProductTypeFromUserInput() {
//    print("Enter the ID of the product type to delete:")
//    if let input = readLine(), let id = Int(input) {
//        // Check if a product type with the input ID exists
//        if let productType = productManager.productTypes.first(where: { $0.id == id }) {
//            // Remove the product type from the productTypes array
//            productManager.productTypes.removeAll(where: { $0.id == id })
//            print("Product type '\(productType.product_type)' (ID: \(id)) deleted successfully!")
//        } else {
//            print("Unable to delete product type. Invalid ID.")
//        }
//    } else {
//        print("Invalid input. Please enter a valid ID.")
//    }
//}

//func addProductPostFromUserInput() {
//    // Prompt the user for the product post ID
//    print("Enter the ID for this product post:")
//    guard let id = readLine().flatMap(Int.init) else {
//        print("Invalid ID")
//        return
//    }
//
//    // Get product type ID from user input
//    print("Enter the ID of the product type for this post:")
//    guard let product_type_id = readLine().flatMap(Int.init) else {
//        print("Invalid input")
//        return
//    }
//
//    // Get company ID from user input
//    print("Enter the ID of the company for this post:")
//    guard let company_id = readLine().flatMap(Int.init) else {
//        print("Invalid input")
//        return
//    }
//
//    // Get product ID from user input
//    print("Enter the ID of the product for this post:")
//    guard let product_id = readLine().flatMap(Int.init) else {
//        print("Invalid input")
//        return
//    }
//
//    // Get posted date from user input
//    print("Enter the posted date for this post (yyyy-MM-dd):")
//    guard let posted_date_string = readLine() else {
//        print("Invalid input")
//        return
//    }
//    let formatter = DateFormatter()
//    formatter.dateFormat = "yyyy-MM-dd"
//    guard let posted_date = formatter.date(from: posted_date_string) else {
//        print("Invalid date format")
//        return
//    }
//
//    // Get price from user input
//    print("Enter the price for this post:")
//    guard let price = readLine().flatMap(Double.init) else {
//        print("Invalid input")
//        return
//    }
//
//    // Get description from user input
//    print("Enter the description for this post:")
//    guard let description = readLine() else {
//        print("Invalid input")
//        return
//    }
//    if productManager.companies.contains(where: { $0.id == company_id }) && productManager.productTypes.contains(where: { $0.id == product_type_id }) && productManager.products.contains(where: { $0.id == product_id }){
//    // Create the product post object and add it to the product post manager
//    let productPost = Product_Post(product_post_id: id, product_type_id: product_type_id, company_id: company_id, product_id: product_id, posted_date: posted_date, price: price, description: description)
//        productManager.addProductPost(productPost: productPost)
//    } else if !productManager.companies.contains(where: { $0.id == company_id }) {
//        print("Invalid company ID")
//        return
//    } else if !productManager.productTypes.contains(where: { $0.id == product_type_id }) {
//        print("Invalid product type ID")
//        return
//    } else if !productManager.products.contains(where: { $0.id == product_id }) {
//        print("Invalid product ID")
//        return
//    }
//}

//func updateProductPostFromUserInput() {
//    // Get product post ID from user input
//    print("Enter the ID of the product post you want to update:")
//    guard let productPostID = readLine(),
//          let productPostIDInt = Int(productPostID) else {
//        print("Invalid product post ID.")
//        return
//    }
//
//    // Find the product post in the productPosts array
//    guard let productPost = productManager.productPosts.first(where: { $0.product_post_id == productPostIDInt }) else {
//        print("Product post not found.")
//        return
//    }
//
//    // Get updated information from user input
//    print("Enter the updated product ID:")
//    guard let productID = readLine(),
//          let productIDInt = Int(productID) else {
//        print("Invalid product ID.")
//        return
//    }
//    productPost.product_id = productIDInt
//
//    print("Enter the updated company ID:")
//    guard let companyID = readLine(),
//          let companyIDInt = Int(companyID) else {
//        print("Invalid company ID.")
//        return
//    }
//    productPost.company_id = companyIDInt
//
//    print("Enter the updated product type ID:")
//    guard let productTypeID = readLine(),
//          let productTypeIDInt = Int(productTypeID) else {
//        print("Invalid product type ID.")
//        return
//    }
//    productPost.product_type_id = productTypeIDInt
//
//    print("Enter the updated description:")
//    if let description = readLine() {
//        productPost.description = description
//    }
//
//    print("Enter the updated price:")
//    if let price = readLine(),
//       let priceDouble = Double(price) {
//        productPost.price = priceDouble
//    }
//
//    print("Enter the updated posted date (yyyy-MM-dd):")
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd"
//    if let dateString = readLine(), let date = dateFormatter.date(from: dateString) {
//        productPost.posted_date = date
//    }
//
//    if productManager.companies.contains(where: { $0.id == companyIDInt }) && productManager.productTypes.contains(where: { $0.id == productTypeIDInt }) && productManager.products.contains(where: { $0.id == productIDInt }){
//            // Update the product post in the productPosts array
//            productManager.updateProductPost(productPost: productPost)
//        } else if !productManager.companies.contains(where: { $0.id == companyIDInt }) {
//            print("Invalid company ID")
//            return
//        } else if !productManager.productTypes.contains(where: { $0.id == productTypeIDInt }) {
//            print("Invalid product type ID")
//            return
//        } else if !productManager.products.contains(where: { $0.id == productIDInt }) {
//            print("Invalid product ID")
//            return
//        }
//}
    
//func deleteProductPostFromUserInput() {
//    print("Enter the ID of the product post you want to delete:")
//    if let id = readLine(), let productPostId = Int(id) {
//        // Find the product post with the given ID
//        if let productPost = productManager.productPosts.first(where: { $0.product_post_id == productPostId }) {
//            // Delete the product post
//            productManager.deleteProductPost(productPost: productPost)
//        } else {
//            print("Product post not found. Invalid ID.")
//        }
//    } else {
//        print("Invalid input. Please enter a valid ID.")
//    }
//}

func search() {
    
    print("Enter your search query:")
    guard let query = readLine() else {
        print("Invalid search query.")
        return
    }
    
    var searchResults: [String] = []
    
    // Search for products
    let matchingProducts = productManager.products.filter { $0.name.lowercased().contains(query.lowercased()) }
    if !matchingProducts.isEmpty {
        let productNames = matchingProducts.map { $0.name }
        searchResults.append("Products: \(productNames.joined(separator: ", "))")
    }
    
    // Search for product types
    let matchingProductTypes = productManager.productTypes.filter { $0.product_type.lowercased().contains(query.lowercased()) }
        if !matchingProductTypes.isEmpty {
            let productTypeNames = matchingProductTypes.map { $0.product_type }
            searchResults.append("Product Types: \(productTypeNames.joined(separator: ", "))")
        }

    
    // Search for product posts
    let matchingProductPosts = productManager.productPosts.filter { $0.description.lowercased().contains(query.lowercased()) }
    if !matchingProductPosts.isEmpty {
        let productPostDescriptions = matchingProductPosts.map { $0.description }
        searchResults.append("Product Posts: \(productPostDescriptions.joined(separator: ", "))")
    }
    
    // Search for companies
    let matchingCompanies = productManager.companies.filter { $0.name.lowercased().contains(query.lowercased()) }
    if !matchingCompanies.isEmpty {
        let companyNames = matchingCompanies.map { $0.name }
        searchResults.append("Companies: \(companyNames.joined(separator: ", "))")
    }
    
    // Search for ratings
    let matchingRatings = productManager.products.filter { String($0.product_rating).lowercased().contains(query.lowercased())}
    if !matchingRatings.isEmpty {
        let productNames = matchingRatings.map { $0.name }
        searchResults.append("Products with matching ratings: \(productNames.joined(separator: ", "))")
    }

    if searchResults.isEmpty {
        print("No results found.")
    } else {
        print("Search results:")
        for result in searchResults {
            print("- \(result)")
        }
    }
}

while true {
    print("Select an option:")
    print("1. Add a product")
    print("2. View all products")
    print("3. Add a company")
    print("4. Delete a company")
    print("5. Add a product type")
    print("6. Delete a product type")
    print("7. View all companies")
    print("8. View all product types")
    print("9. Manage Product posts")
    print("10. Search")
    print("0. Back")

    if let choice = readLine().flatMap(Int.init) {
            switch choice {
            case 1:
                addProductFromUserInput()
            case 2:
                let products = productManager.viewAllProducts()
                for product in products {
                    print(" \(product.id) \(product.name)")
                }
                // Display the products
            case 3:
                addCompanyFromUserInput()
            case 4:
                deleteCompanyFromUserInput()
            case 5:
                addProductTypeFromUserInput()
            case 6:
                deleteProductTypeFromUserInput()
            case 7:
                let companies = productManager.viewAllCompanies()
                for company in companies {
                    print(company.name)
                }
            case 8:
                let productTypes = productManager.viewAllProductTypes()
                for productType in productTypes {
                    print("Product Type Name: \(productType.product_type)")
                    // print other properties if they exist
                }
            case 9:
                Product_Post_Menu()
            case 10:
                search()
            case 0:
                break // exit the loop if user selects "back"
            default:
                print("Invalid choice")
            }

            if choice == 0 {
                break // exit the loop if user selects "back"
            }
        } else {
            print("Invalid input")
        }
    //  Product_Post menu
    func Product_Post_Menu(){
        while true {
            print("Select an option:")
            print("1. Add a product post")
            print("2. View all product posts")
            print("3. Update a product post")
            print("4. Delete a product post")
            print("0. Back")

            if let choice = readLine().flatMap(Int.init) {
                switch choice {
                case 1:
                    addProductPostFromUserInput()
                case 2:
                    let productPosts = productManager.viewAllProductPosts()
                    for productPost in productPosts {
                        print("Product Post ID: \(productPost.product_post_id)")
                        print("Product Type ID: \(productPost.product_type_id)")
                        print("Company ID: \(productPost.company_id)")
                        print("Product ID: \(productPost.product_id)")
                        print("Posted Date: \(productPost.posted_date)")
                        print("Price: \(productPost.price)")
                        print("Description: \(productPost.description)")
                    }
                case 3:
                    updateProductPostFromUserInput()
                case 4:
                    deleteProductPostFromUserInput()
                case 0:
                    break // exit the loop if user selects "back"
                default:
                    print("Invalid choice")
                }

                if choice == 0 {
                    break // exit the loop if user selects "back"
                }
            } else {
                print("Invalid input")
            }
        }
    }
    // Search Menu
    func search() {
        print("What would you like to search by?")
        print("1. Product")
        print("2. Product Type")
        print("3. Product Post")
        print("4. Company")
        print("5. Ratings")
        print("0. Back")
        
        guard let choice = readLine(), let category = Int(choice) else {
            print("Invalid choice.")
            return
        }

        switch category {
        case 1: // Product
            print("Enter an ID to search for:")
            guard let idString = readLine(), let id = Int(idString) else {
                print("Invalid ID. Please enter a valid integer ID.")
                return
            }
            guard let product = productManager.products.first(where: { $0.id == id }) else {
                print("Product not found.")
                return
            }
            print("Matching product type:")
            print("ID: \(product.id)")
            print("Name: \(product.name)")
            print("Description: \(product.product_description)")
            print("Rating: \(product.product_rating)")
            print("Company ID: \(product.company_id)")
            print("Quantity: \(product.quantity)")
            
            
        case 2: // Product Type
            print("Enter an ID to search for:")
            guard let idString = readLine(), let id = Int(idString) else {
                print("Invalid ID. Please enter a valid integer ID.")
                return
            }
            guard let productTypes = productManager.productTypes.first(where: { $0.id == id }) else {
                print("Product type not found.")
                return
            }
            print("Matching product type:")
            print("ID: \(productTypes.id)")
            print("Product type: \(productTypes.product_type)")
            
        case 3: // Product Post
            print("Enter an ID to search for:")
            guard let idString = readLine(), let id = Int(idString) else {
                print("Invalid ID. Please enter a valid integer ID.")
                return
            }
            guard let productPost = productManager.productPosts.first(where: { $0.product_post_id == id }) else {
                print("Product post not found.")
                return
            }
            print("Matching product post:")
                    print("Product post ID: \(productPost.product_post_id)")
                    print("Product type ID: \(productPost.product_type_id)")
                    print("Company ID: \(productPost.company_id)")
                    print("Product ID: \(productPost.product_id)")
                    print("Description: \(productPost.description)")
                    print("Posted date: \(productPost.posted_date)")
                    print("Price: \(productPost.price)")
            
        case 4: // Company
            print("Enter an ID to search for:")
            guard let idString = readLine(), let id = Int(idString) else {
                print("Invalid ID. Please enter a valid integer ID.")
                return
            }
            guard let companies = productManager.companies.first(where: { $0.id == id }) else {
                print("Company not found.")
                return
            }
            print("Matching company:")
            print("ID: \(companies.id)")
            print("Name: \(companies.name)")
            print("Address: \(companies.address)")
            print("Country: \(companies.country)")
            print("Zip: \(companies.zip)")
            
        case 5: // Ratings
            print("Enter a rating to search for:")
            guard let ratingString = readLine(), let rating = Double(ratingString) else {
                print("Invalid rating. Please enter a valid number.")
                return
            }
            let matchingProducts = productManager.products.filter { $0.product_rating == rating }
            if !matchingProducts.isEmpty {
                print("Products with rating \(rating):")
                   for product in matchingProducts {
                      print("ID: \(product.id)")
                      print("Name: \(product.name)")
                      print("Description: \(product.product_description)")
                      print("Rating: \(product.product_rating)")
                      print("Company ID: \(product.company_id)")
                      print("Quantity : \(product.quantity)")
                   }
            } else {
                print("No products found with rating \(rating).")
            }
        case 0:
            break // exit the loop if user selects "back"
        default:
            print("Invalid choice.")
        }
    }
}

