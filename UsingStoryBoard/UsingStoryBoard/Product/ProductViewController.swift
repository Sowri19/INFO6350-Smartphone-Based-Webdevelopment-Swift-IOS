//
//  ProductViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//

import UIKit
import CoreData

protocol ProductViewControllerDelegate: AnyObject {
    func didAddProduct(Product: ProductData)
    func didUpdateProduct(Product: ProductData)
}

class ProductViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var ProductIdField: UITextField!
    @IBOutlet weak var ProductNameField: UITextField!
    @IBOutlet weak var ProductDescriptionField: UITextField!
    @IBOutlet weak var ProductRatingField: UITextField!
    @IBOutlet weak var ProductCompanyIdField: UITextField!
    @IBOutlet weak var ProductQuantityField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    weak var delegate: ProductViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
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
        guard let imageData = logoImageView.image?.jpegData(compressionQuality: 1.0) else {
                    let alert = UIAlertController(title: "Error", message: "Failed to convert image to data", preferredStyle: .alert)
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
            newProduct.logo = imageData
            // Save changes
        
        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Product added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            // Call the delegate method with the newly created Product
            delegate?.didAddProduct(Product: newProduct)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
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
        guard let imageData = logoImageView.image?.jpegData(compressionQuality: 1.0) else {
                let alert = UIAlertController(title: "Error", message: "Failed to convert image to data", preferredStyle: .alert)
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
                    productToUpdate.logo = imageData
                    try context.save()
                    
                    let alert = UIAlertController(title: "Product Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    // Call the delegate method with the newly created product
                    delegate?.didUpdateProduct(Product: productToUpdate)
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
}
