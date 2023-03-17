//
//  main.swift
//  Assignment5
//
//  Created by Sowri on 2/26/23.
//

import Foundation

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
            print("Product added successfully! Product type: \(productType.product_type)")
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

