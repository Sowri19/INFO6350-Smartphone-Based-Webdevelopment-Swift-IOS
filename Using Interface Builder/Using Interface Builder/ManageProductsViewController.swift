//
//  ManageProductsViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit
import CoreData

class ManageProductsViewController: UIViewController {

    @IBOutlet weak var ProductIdField: UITextField!
    @IBOutlet weak var ProductNameField: UITextField!
    @IBOutlet weak var ProductDescriptionField: UITextField!
    @IBOutlet weak var ProductRatingField: UITextField!
    @IBOutlet weak var ProductCompanyIdField: UITextField!
    @IBOutlet weak var ProductQuantityField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addProductButtonTapped(_ sender: UIButton) {
    let vc = ManageProductsViewController(nibName: "AddProductView", bundle: nil)
    self.present(vc, animated: true, completion: nil)
    }
    @IBAction func deleteProductButtonTapped(_ sender: UIButton) {
        let vc = ManageProductsViewController(nibName: "DeleteProductView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateProductButtonTapped(_ sender: UIButton) {
        let vc = ManageProductsViewController(nibName: "UpdateProductView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllProductsButtonTapped(_ sender: UIButton) {
        let vc = ManageProductsViewController(nibName: "ViewAllProductsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
        if let textView = vc.textView {
                viewAllProducts(textView: textView)
                    }
    }

    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func AddProduct(_ sender: UIButton) {
        print("Add Product button pressed")
            guard let idText = ProductIdField?.text, let productId = Int(idText),
                  let productName = ProductNameField?.text, !productName.isEmpty,
                  let productDescription = ProductDescriptionField?.text, !productDescription.isEmpty,
                  let productRatingText = ProductRatingField?.text, let productRating = Double(productRatingText),
                  let productCompanyIdText = ProductCompanyIdField?.text, let productCompanyId = Int(productCompanyIdText),
                  let productQuantityText = ProductQuantityField?.text, let productQuantity = Int(productQuantityText), productRating <= 5
            else {
                let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            // Check if product already exists
            let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %ld OR name == %@", productId, productName)
            do {
                let existingProducts = try context.fetch(fetchRequest)
                if existingProducts.count > 0 {
                    var errorMessage = "Product with the following already exists:\n"
                    if existingProducts.contains(where: { $0.id == productId }) {
                        errorMessage += "ID: \(productId)\n"
                    }
                    if existingProducts.contains(where: { $0.name == productName }) {
                        errorMessage += "Product Name: \(productName)\n"
                    }
                    let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            // Check if company exists
            let companyFetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            companyFetchRequest.predicate = NSPredicate(format: "id == %ld", productCompanyId)
            do {
                let companies = try context.fetch(companyFetchRequest)
                if companies.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            // Create new product object
            let newProduct = ProductData(context: context)
            newProduct.id = Int64(productId)
            newProduct.name = productName
            newProduct.product_description = productDescription
            newProduct.product_rating = productRating
            newProduct.company_id = Int64(productCompanyId)
            newProduct.quantity = Int64(productQuantity)
            // Save changes
        
        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Product added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func DeleteProduct(_ sender: UIButton) {
        print("Delete Product button pressed")
        if let idText = ProductIdField?.text, let productId = Int(idText) {
            
            let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            fetchRequest.predicate = NSPredicate(format: "id == %d", productId)
            do {
                let results = try context.fetch(fetchRequest)
                if let productToDelete = results.first {
                    context.delete(productToDelete)
                    try context.save()
                    // Deletion was successful
                    let alert = UIAlertController(title: "Product Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    // Deletion failed
                    let alert = UIAlertController(title: "Error", message: "Product ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } catch {
                // handle error
                print("Error deleting product: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to delete product.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Product ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }

    @IBAction func UpdateProduct(_ sender: UIButton) {
        print("Update Product button pressed")
            guard let idText = ProductIdField.text, let productId = Int(idText),
                let nameText = ProductNameField.text, !nameText.isEmpty,
                let descriptionText = ProductDescriptionField.text, !descriptionText.isEmpty,
                let companyIdText = ProductCompanyIdField.text, let companyId = Int(companyIdText),
                let quantityText = ProductQuantityField.text, let quantity = Int(quantityText),
                let ratingText = ProductRatingField.text, let rating = Double(ratingText), rating <= 5 else {
                    let alert = UIAlertController(title: "Error", message: "Please enter a valid Product ID, Name, Description, Quantity, Rating, and Company ID and ensure rating less than or equal to 5", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
            }

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            // Check if company exists
            let companyFetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            companyFetchRequest.predicate = NSPredicate(format: "id == %ld", companyId)
            do {
                let companies = try context.fetch(companyFetchRequest)
                if companies.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Update the product
            let fetchRequestToUpdate: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            fetchRequestToUpdate.predicate = NSPredicate(format: "id == %ld", productId)
        do {
                let result = try context.fetch(fetchRequestToUpdate)
                
                if let productToUpdate = result.first {
                    productToUpdate.name = nameText
                    productToUpdate.product_description = descriptionText
                    productToUpdate.company_id = Int64(companyId)
                    productToUpdate.quantity = Int64(quantity)
                    productToUpdate.product_rating = rating
                    
                    try context.save()
                    
                    let alert = UIAlertController(title: "Product Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Product ID does not exist to update.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } catch {
                let alert = UIAlertController(title: "Error", message: "Failed to update product", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    func viewAllProducts(textView: UITextView) {
        // Get the managed object context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            // Create a fetch request for the ProductData entity
            let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            
            // Fetch all products from Core Data
            let products = try context.fetch(fetchRequest)
            
            // Construct a string with details of all products
            var productString = ""
            for product in products {
                productString += "ID: \(product.id)\n"
                productString += "Name: \(product.name ?? "")\n"
                productString += "Company ID: \(product.company_id)\n"
                productString += "Rating: \(product.product_rating)\n"
                productString += "Quantity: \(product.quantity)\n"
                productString += "Description: \(product.product_description ?? "")\n\n"
            }
            
            // Set the string as the text for the given UITextView
            textView.text = productString
        } catch {
            // Handle any errors that occur during fetch
            print("Failed to fetch products: \(error.localizedDescription)")
            
            // Check if an alert is already being presented
            guard presentedViewController == nil else {
                return
            }
            
            // Show an alert with the error message
            let alert = UIAlertController(title: "Error", message: "Failed to fetch products.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
