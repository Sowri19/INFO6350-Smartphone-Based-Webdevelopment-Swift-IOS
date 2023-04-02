//
//  ManageProductTypesViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/26/23.
//

import UIKit
import CoreData

class ManageProductTypesViewController: UIViewController {

    

    @IBOutlet weak var ProductTypeIdField: UITextField!
    @IBOutlet weak var ProductTypeField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func AddProductTypeButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "AddProductTypeView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func deleteProductTypeButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "DeleteProductTypeView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func updateProductTypeButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "UpdateProductTypeView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func viewAllProductTypesButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "ViewAllProductTypesView", bundle: nil)
            self.present(vc, animated: true) {
                if let textView: UITextView = vc.TextView {
                    self.viewAllProductTypes(textView: textView)
                }
            }
    }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddProductType(_ sender: UIButton) {
        print("Add Product Type button pressed")
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText) ,let productType = ProductTypeField?.text, !productType.isEmpty {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %lld OR product_type == %@", Int64(productTypeId), productType)

               do {
                   let existingProductTypes = try context.fetch(fetchRequest)
                   if let existingProductType = existingProductTypes.first {
                       var errorMessage = "A product type with the following already exists:\n"
                       if existingProductType.id == Int64(productTypeId) {
                           errorMessage += "ID: \(productTypeId)"
                       }
                       if existingProductType.product_type == productType {
                           errorMessage += "\nProduct Type: \(productType)"
                       }
                       let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                       present(alert, animated: true, completion: nil)
                       return
                   }
                   
                   let newProductType = Producttype(context: context)
                   newProductType.id = Int64(productTypeId)
                   newProductType.product_type = productType

                   try context.save()
                   
                   let alert = UIAlertController(title: "Product Type Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
                   
               } catch let error {
                   let alert = UIAlertController(title: "Error", message: "Failed to save product type with error: \(error.localizedDescription)", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func DeleteProductType(_ sender: UIButton) {
        print("Delete Product Type button pressed")
            guard let idText = ProductTypeIdField?.text,
                  let productTypeId = Int(idText) else {
                // Handle case where idField has no text or the text is not a valid integer
                let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Type ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %ld", productTypeId)

            do {
                let productTypes = try context.fetch(fetchRequest)
                guard let productType = productTypes.first else {
                    // Deletion failed - no product type found with given id
                    let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                
                // Delete the product type from Core Data
                context.delete(productType)
                try context.save()

                // Deletion was successful
                let alert = UIAlertController(title: "Product Type Deleted Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)

            } catch let error {
                // Handle any errors that occur during fetch or delete
                let alert = UIAlertController(title: "Error", message: "Failed to delete product type with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    @IBAction func UpdateProductType(_ sender: UIButton) {
        guard let idText = ProductTypeIdField?.text, let productTypeId = Int(idText),
                let nameText = ProductTypeField?.text, !nameText.isEmpty else {
              let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Type ID and Name", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
          
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
          
          let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
          fetchRequest.predicate = NSPredicate(format: "id == %d", productTypeId)
          
          do {
              let fetchedProductTypes = try context.fetch(fetchRequest)
              guard let productTypeToUpdate = fetchedProductTypes.first else {
                  let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist to update.", preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alert, animated: true, completion: nil)
                  return
              }
              
              if let existingProductType = try? context.fetch(fetchRequest).first {
                  if existingProductType.product_type == nameText {
                      let alert = UIAlertController(title: "Error", message: "Product Type already exists.", preferredStyle: .alert)
                      alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                      present(alert, animated: true, completion: nil)
                      return
                  }
              }
              productTypeToUpdate.product_type = nameText
              try context.save()
              
              let alert = UIAlertController(title: "Product Type Updated Successfully", message: "Press ok to continue", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              
          } catch let error {
              let alert = UIAlertController(title: "Error", message: "Failed to update product type with error: \(error.localizedDescription)", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
          }
    }
    
    func viewAllProductTypes(textView: UITextView) {
        // Create a fetch request for the Producttype entity
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
        
        do {
            // Retrieve all product types from Core Data
                let productTypes = try context.fetch(fetchRequest)

            // Construct a string with details of all product types
            var productTypesString = ""
            for productType in productTypes {
                if let id = productType.id as Int64?, let productTypeStr = productType.product_type {
                    productTypesString += "ID: \(id)\n"
                    productTypesString += "Product Type: \(productTypeStr)\n\n"
                }
            }
            // Set the string as the text for the given UITextView
            textView.text = productTypesString
            
        } catch let error {
            // Handle any errors that occur during fetch
            print("Error fetching product types: \(error.localizedDescription)")
            
            // Check if an alert is already being presented
            guard presentedViewController == nil else {
                return
            }
            let alert = UIAlertController(title: "Error", message: "Failed to fetch product types.", preferredStyle: .alert)
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
