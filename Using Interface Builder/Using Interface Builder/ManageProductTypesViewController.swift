//
//  ManageProductTypesViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/26/23.
//

import UIKit

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
            self.present(vc, animated: true, completion: nil)
        if let textView = vc.TextView {
                viewAllProductTypes(textView: textView)
            }
    }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddProductType(_ sender: UIButton) {
        print("Add Product Type button pressed")
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText) ,let productType = ProductTypeField?.text, !productType.isEmpty {
            let productTypeExists = productManager.productTypes.contains { $0.id == productTypeId || $0.product_type == productType}
            if productTypeExists {
                var errorMessage = "A product type with the following already exists:\n"
                if productManager.productTypes.contains(where: { $0.id == productTypeId }) {
                    errorMessage += "ID: \(productTypeId)"
                }
                if productManager.productTypes.contains(where: { $0.product_type == productType }) {
                    errorMessage += "\nProduct Type: \(productType)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let newProductType = Product_type(id: productTypeId, product_type: productType)
            productManager.addProductType(productType: newProductType)
            let alert = UIAlertController(title: "Product Type Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func DeleteProductType(_ sender: UIButton) {
        print("Delete Product Type button pressed")
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText) {
            let productTypeToDelete = Product_type(id: productTypeId, product_type: "")
            if productManager.deleteProductType(productType: productTypeToDelete) {
                // Deletion was successful
                let alert = UIAlertController(title: "Product Type Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            } else {
                // Deletion failed
                let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Type ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func UpdateProductType(_ sender: UIButton) {
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText), let nameText = ProductTypeField?.text, !nameText.isEmpty{
                let productTypeToUpdate = Product_type(id: productTypeId, product_type: nameText)
                if productManager.updateProductType(productType: productTypeToUpdate) {
                    let alert = UIAlertController(title: "Product Type Updated Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist to update.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // handle case where idField or nameField has no text or the text is not a valid integer
                let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Type ID and Name", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    func viewAllProductTypes(textView: UITextView) {
        let productTypes = productManager.viewAllProductTypes()
        var productTypesString = ""
        for productType in productTypes {
            productTypesString += "ID: \(productType.id)\n"
            productTypesString += "Product Type: \(productType.product_type)\n\n"
        }
        textView.text = productTypesString
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
