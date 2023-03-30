//
//  ManageProductsViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit

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
        if let idText = ProductIdField?.text, let productId = Int(idText) ,let productName = ProductNameField?.text, !productName.isEmpty,
           let productDescription = ProductDescriptionField?.text, !productDescription.isEmpty, let productRating =  ProductRatingField?.text, let ProductRating = Double(productRating), let productCompanyId = ProductCompanyIdField?.text, let ProductCompanyId = Int(productCompanyId), let productQuantity = ProductQuantityField?.text, let ProductQuantity = Int(productQuantity)
        {
            let productTypeExists = productManager.products.contains { $0.id == productId || $0.name == productName}
            if productTypeExists {
                var errorMessage = "Product with the following already exists:\n"
                if productManager.products.contains(where: { $0.id == productId }) {
                    errorMessage += "ID: \(productId)"
                }
                if productManager.products.contains(where: { $0.name == productName }) {
                    errorMessage += "\nProduct Name: \(productName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                let companyExists = productManager.companies.contains { $0.id == ProductCompanyId }
                if !companyExists {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else if ProductRating > 5 {
                    let alert = UIAlertController(title: "Error", message: "Rating must be between 1 and 5", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    let newProduct = Product(id: productId, name: productName, product_description: productDescription, product_rating: ProductRating, company_id: ProductCompanyId, quantity: ProductQuantity)
                    productManager.addProduct(product: newProduct)
                    let alert = UIAlertController(title: "Product Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func DeleteProduct(_ sender: UIButton) {
        print("Delete Product button pressed")
        if let idText = ProductIdField?.text, let productId = Int(idText) {
            let productToDelete = Product(id: productId, name: "", product_description: "", product_rating: 0, company_id: 0, quantity: 0)
            if productManager.deleteProduct(product: productToDelete) {
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
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Product ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }

    @IBAction func UpdateProduct(_ sender: UIButton) {
        print("Update Product button pressed")
          if let idText = ProductIdField?.text, let productId = Int(idText), let nameText = ProductNameField?.text, !nameText.isEmpty,
             let descriptionText = ProductDescriptionField?.text, !descriptionText.isEmpty,
             let companyIdText = ProductCompanyIdField?.text, let companyId = Int(companyIdText), let quantityText = ProductQuantityField?.text, let quantity = Int(quantityText),
             let ratingText = ProductRatingField?.text, let rating = Double(ratingText) {
              
              let productToUpdate = Product(id: productId, name: nameText, product_description: descriptionText, product_rating: rating, company_id: companyId, quantity: quantity)
              if productManager.updateProduct(product: productToUpdate) {
                  let alert = UIAlertController(title: "Product Updated Successfully", message: "Press ok to continue", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alert, animated: true, completion: nil)
                  return
              } else {
                  let alert = UIAlertController(title: "Error", message: "Product ID does not exist to update.", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alert, animated: true, completion: nil)
              }
          } else {
              // handle case where any field has no text
              let alert = UIAlertController(title: "Error", message: "Please enter a valid Product ID, Name, Description, Quantity, Rating, and Company ID", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
          }
    }
    
    func viewAllProducts(textView: UITextView) {
        let products = productManager.viewAllProducts()
        var productString = ""
        for product in products {
            productString += "Product ID: \(product.id)\n"
            productString += "Name: \(product.name)\n"
            productString += "Company ID: \(product.company_id)\n"
            productString += "Rating: \(product.product_rating)\n"
            productString += "Quantity: \(product.quantity)\n"
            productString += "Description: \(product.product_description)\n\n"
        }
        textView.text = productString
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
