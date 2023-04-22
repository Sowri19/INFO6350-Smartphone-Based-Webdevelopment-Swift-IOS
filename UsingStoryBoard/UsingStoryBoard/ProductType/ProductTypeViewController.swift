//
//  ProductTypeViewController.swift
//  UsingStoryBoard
//

import UIKit
import CoreData


protocol ProductTypeViewControllerDelegate: AnyObject {
    func didAddProductType(productType: Producttype)
    func didUpdateProductType(productType: Producttype)
}

class ProductTypeViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate  {

    @IBOutlet weak var ProductTypeIdField: UITextField!
    @IBOutlet weak var ProductTypeField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let imagePicker = UIImagePickerController()
    
    weak var delegate: ProductTypeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Add tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        ProductTypeIdField.delegate = self
        ProductTypeField.delegate=self
        scrollView.delegate = self
    }
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Calculate the total height of all subviews
        var totalHeight: CGFloat = 0.0
        for subview in scrollView.subviews {
            totalHeight += subview.frame.height
        }
        // Set the content size of the scroll view based on the subviews' frames
        scrollView.contentSize = CGSize(width: view.frame.width, height: totalHeight)
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
    
    @IBAction func AddProductType(_ sender: UIButton) {
        print("Add Product Type button pressed")
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText), let productType = ProductTypeField?.text, !productType.isEmpty {
            guard let imageData = logoImageView.image?.jpegData(compressionQuality: 1.0) else {
                        let alert = UIAlertController(title: "Error", message: "Failed to convert image to data", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    }
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
                newProductType.logo = imageData // Set the image data to the 'image' property of Producttype entity as PNG data

                try context.save()
                let alert = UIAlertController(title: "Product Type Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                
                // Call the delegate method with the newly created product type
                delegate?.didAddProductType(productType: newProductType)

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
    
    @IBAction func UpdateProductType(_ sender: UIButton) {
        guard let idText = ProductTypeIdField?.text, let productTypeId = Int(idText),
                let nameText = ProductTypeField?.text, !nameText.isEmpty else {
              let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Type ID and Name", preferredStyle: .alert)
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
              productTypeToUpdate.logo = imageData // Set the image data to the 'image' property of Producttype entity as PNG data
              try context.save()
              
              let alert = UIAlertController(title: "Product Type Updated Successfully", message: "Press ok to continue", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              // Call the delegate method with the newly created product type
              delegate?.didUpdateProductType(productType: productTypeToUpdate)
          } catch let error {
              let alert = UIAlertController(title: "Error", message: "Failed to update product type with error: \(error.localizedDescription)", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
          }
    }

}
