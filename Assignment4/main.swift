import Foundation

// Category struct
struct Category {
    var name: String
    var products: [Product]
    
    init(name: String) {
        self.name = name
        self.products = []
    }
}

class Admin {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

// Product struct
class Product {
    var name: String
    var cost: Double?
    var quantity: Int?
    var expiryDate: Date?
    var information: [String]?
    private var _productInformation: [String: Any]?

    var productInformation: [String: Any]? {
        get {
            if _productInformation == nil {
                _productInformation = [:]
            }
            return _productInformation
        }
        set {
            _productInformation = newValue
        }
    }

    init(name: String, cost: Double? = nil, quantity: Int? = nil, expiryDate: Date? = nil, information: [String] = [], productInformation: [String: Any]? = nil) {
        self.name = name
        self.cost = cost
        self.quantity = quantity
        self.expiryDate = expiryDate
        self.information = information
        self._productInformation = productInformation
    }
}


// Grocery Store class
class GroceryStore {
    private var categories: [Category]
    init() {
        self.categories = [
            Category(name: "Dairy"),
            Category(name: "Vegetables"),
            Category(name: "Fruits"),
            Category(name: "Meat")
        ]
    }
    func displayCategories() {
        while true {
            print("\nCategories:")
            for (index, category) in categories.enumerated() {
                print("\(index + 1). \(category.name)")
            }
            print("Please select an option:")
            print("50. Add a Category")
            print("51. Update a Category")
            print("52. Delete a Category")
            print("53. Go back")
            print("Choice: ", terminator: "")
            if let choice = readLine(), let categoryIndex = Int(choice) {
                if categoryIndex == 0 {
                    break
                } else if categoryIndex == 50 {
                    addCategory()
                } else if categoryIndex == 51 {
                    updateCategory()
                } else if categoryIndex == 52 {
                    deleteCategory()
                } else if categoryIndex > 0 && categoryIndex <= categories.count {
                    let selectedCategory = categories[categoryIndex - 1]
                    print("\nSelected category: \(selectedCategory.name)\n")
//                    print("Sample products in \(selectedCategory.name):")
                    for product in selectedCategory.products {
                        print("\(product.name)")
                    }
                    print("\nOptions:")
                    print("1. Add product")
//                    print("2. Update product")
                    print("2. Delete product")
                    print("3. Select Product")
                    print("0. Go back")
                    
                    if let option = readLine(), let optionIndex = Int(option) {
                        switch optionIndex {
                        case 0:
                            return // exit the inner loop and return to previous menu
                        case 1:
                            var updatedCategory = selectedCategory
                            addProductToCategory(&updatedCategory)
                            // replace the original category with the updated one
                            if let categoryIndex = categories.firstIndex(where: { $0.name == selectedCategory.name }) {
                                categories[categoryIndex] = updatedCategory
                            }
                        case 2:
                            var deleteCategory = selectedCategory
                            deleteProductInCategory(&deleteCategory)
                            // replace the original category with the updated one
                            if let categoryIndex = categories.firstIndex(where: { $0.name == selectedCategory.name }) {
                                categories[categoryIndex] = deleteCategory
                            }
                        case 3:
                            func displayProductInformation(product: inout Product) {
                                print("\nProduct information:")

                                if let productInformation = product.productInformation {
                                    for (key, value) in productInformation {
                                        print("\(key): \(value)")
                                    }
                                }
                                if let information = product.information, !information.isEmpty {
                                    print("\nAdditional information:")
                                    for info in information {
                                        print("- \(info)")
                                    }
                                }

                                // Provide option to add, delete or go back to parameters menu
                                print("\nSelect an option:")
                                print("1. Add parameter")
                                print("2. Delete parameter")
                                print("3. Update parameter")
                                print("4. Go back to previous menu")
                                
                                if let choice = readLine()?.lowercased(), let index = Int(choice) {
                                    switch index {
                                    case 1:
                                        // Add parameter
                                        print("\nEnter parameter name:")
                                        if let name = readLine()?.lowercased(), !name.isEmpty {
                                            print("Enter parameter value:")
                                            if let value = readLine()?.lowercased() {
                                                product.productInformation?[name] = value
                                                print("Parameter added.")
                                            }
                                        }
                                        
                                        // Add option to go back to parameters menu
                                        print("\n1. Go back to parameters menu")
                                        if let choice = readLine(), choice == "1" {
                                            // Do nothing and exit switch statement to return to parameters menu
                                        } else {
                                            print("Invalid choice.")
                                        }
                                        
                                    case 2:
                                        // Delete parameter
                                        print("\nEnter parameter name to delete:")
                                        if let name = readLine()?.lowercased(), !name.isEmpty {
                                            if let productInformation = product.productInformation {
                                                if productInformation[name] != nil {
                                                    var updatedProductInformation = productInformation
                                                    updatedProductInformation.removeValue(forKey: name)
                                                    product.productInformation = updatedProductInformation
                                                    print("Parameter deleted.")
                                                } else {
                                                    print("Invalid parameter name.")
                                                    print("Available parameter names: \(productInformation.keys)")
                                                }
                                            } else {
                                                print("No parameters to delete.")
                                            }
                                        } else {
                                            print("Invalid parameter name.")
                                        }
                                        
                                        // Add option to go back to parameters menu
                                        print("\n1. Go back to parameters menu")
                                        if let choice = readLine(), choice == "1" {
                                            // Do nothing and exit switch statement to return to parameters menu
                                        } else {
                                            print("Invalid choice.")
                                        }
                                    case 3:
                                                // Update parameter
                                                print("\nEnter parameter name to update:")
                                                if let name = readLine()?.lowercased(), !name.isEmpty {
                                                    if let productInformation = product.productInformation {
                                                        if productInformation[name] != nil {
                                                            print("Enter parameter value:")
                                                            if let value = readLine()?.lowercased() {
                                                                product.productInformation?[name] = value
                                                                print("Parameter updated.")
                                                            }
                                                        } else {
                                                            print("Invalid parameter name.")
                                                            print("Available parameter names: \(productInformation.keys)")
                                                        }
                                                    } else {
                                                        print("No parameters to update.")
                                                    }
                                                } else {
                                                    print("Invalid parameter name.")
                                                }
                                                // Add option to go back to previous menu
                                                print("\n1. Go back to previous menu")
                                                if let choice = readLine(), choice == "1" {
                                                    // Do nothing and exit switch statement to return to previous menu
                                                } else {
                                                    print("Invalid choice.")
                                                }
                                    case 4:
                                        // Go back to previous menu
                                        break
                                        
                                    default:
                                        print("Invalid choice.")
                                    }
                                } else {
                                    print("Invalid choice.")
                                }
                            }

                            
                                func displayProductMenu(for category: Category) {
                                        print("\nSelected category: \(category.name)\n")
                                        print("Products:")
                                        for (index, product) in category.products.enumerated() {
                                            print("\(index + 1). \(product.name)")
                                        }
                                        print("0. Go back to main menu")
                                        print("Please select a product:")
                                        print("Choice: ", terminator: "")
//                                    while true{
                                        if let choice = readLine(), let productIndex = Int(choice) {
                                            if productIndex == 0 {
                                                return // exit the function and return to previous menu
                                            } else if productIndex > 0 && productIndex <= category.products.count {
                                                var selectedProduct = category.products[productIndex - 1]
                                                displayProductInformation(product: &selectedProduct)
                                            } else {
                                                print("Invalid choice. Please enter a number from 0 to \(category.products.count).")
                                            }
                                        }
//                                    }
                                    }
                                displayProductMenu(for: selectedCategory)
                            
                            
                        default:
                            print("Invalid option.")
                        }
                    }
            }
        } else {
                    print("Invalid choice. Please enter a number from 0 to \(categories.count).")
                }
        }
    }
    // Add Category function
    func addCategory() {
        print("Enter name of new category: ", terminator: "")
        let name = readLine() ?? ""

        if categories.contains(where: { $0.name == name }) {
            print("Category already exists. Please try again.")
        } else {
            categories.append(Category(name: name))
            print("Category added successfully.")
        }
    }

    // Update Category function
    func updateCategory() {
        print("Enter name of category to update: ", terminator: "")
        let name = readLine() ?? ""

        if let categoryIndex = categories.firstIndex(where: { $0.name == name }) {
            print("Enter new name for the category: ", terminator: "")
            let newName = readLine() ?? ""

            if categories.contains(where: { $0.name == newName }) {
                print("Category already exists. Please try again.")
            } else {
                categories[categoryIndex].name = newName
                print("Category updated successfully.")
            }
        } else {
            print("Category not found. Please try again.")
        }
    }
    
//    Delete Category function
    func deleteCategory() {
        print("Enter the name of the category you want to delete:")
        if let categoryName = readLine()?.lowercased(), !categoryName.isEmpty {
            if let index = categories.firstIndex(where: { $0.name.lowercased() == categoryName }) {
                let category = categories[index]
                if category.products.isEmpty {
                    categories.remove(at: index)
                    print("Category deleted.")
                } else {
                    print("Category cannot be deleted because it contains products.")
                }
            } else {
                print("Category not found.")
            }
        } else {
            print("Invalid category name.")
        }
    }
  
}
func addProductToCategory(_ category: inout Category) {
    print("Enter the name of the new product:")
    guard let productName = readLine(), !productName.isEmpty else {
        print("Invalid input. Please enter a product name.")
        return
    }
    

    let newProduct = Product(name: productName)


    category.products.append(newProduct)
    
    print("Product added to category: \(category.name)")
}


func deleteProductInCategory(_ category: inout Category) {
    print("Enter the name of the product to delete:")
    if let productName = readLine()?.lowercased(), !productName.isEmpty {
        if let index = category.products.firstIndex(where: { $0.name.lowercased() == productName }) {
            let product = category.products[index]
            if let productInformation = product.productInformation, !productInformation.isEmpty {
                print("Cannot delete product. Product has parameters.")
                return
            }
            category.products.remove(at: index)
            print("Product deleted.")
        } else {
            print("Product not found.")
        }
    } else {
        print("Invalid product name.")
    }
}



print("Enter your email: ", terminator: "")
let email = readLine() ?? ""

print("Enter your password: ", terminator: "")
let password = readLine() ?? ""

let admin = Admin(email: "sowri@example.com", password: "secret")

if email == admin.email && password == admin.password {
    print("Login successful")
    print("Welcome to the Grocery Store!")
    let store = GroceryStore()
    store.displayCategories()
} else {
    print("Invalid email or password. Please try again.")
}



