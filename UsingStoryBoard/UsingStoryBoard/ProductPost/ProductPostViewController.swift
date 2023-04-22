//
//  ProductPostViewController.swift
//  UsingStoryBoard


import UIKit
import CoreData

protocol ProductPostViewControllerDelegate: AnyObject {
    func didAddProductPost(ProductPost: ProductPostData)
    func didUpdateProductPost(ProductPost: ProductPostData)
}

class ProductPostViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate, UIScrollViewDelegate  {
    @IBOutlet weak var ProductPostIdField: UITextField!
    @IBOutlet weak var ProductPostProductTypeIdField: UITextField!
    @IBOutlet weak var ProductPostCompanyIdField: UITextField!
    @IBOutlet weak var ProductPostProductIdField: UITextField!
    @IBOutlet weak var ProductPostPostedDateField: UITextField!
    @IBOutlet weak var ProductPostPriceField: UITextField!
    @IBOutlet weak var ProductPostDescriptionField: UITextField!
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var scrollView: UIScrollView!
        
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: ProductPostViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Add tap gesture recognizer to dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        ProductPostIdField.delegate = self
        ProductPostProductTypeIdField.delegate=self
        ProductPostCompanyIdField.delegate=self
        ProductPostProductIdField.delegate=self
//        ProductPostPostedDateField.delegate = self
        ProductPostPriceField.delegate = self
        ProductPostDescriptionField.delegate = self
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

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addProductPost(_ sender: UIButton) {
        
        print("Add Product Post button pressed")
         guard let postIdText = ProductPostIdField?.text, let postId = Int(postIdText),
               let productTypeIdText = ProductPostProductTypeIdField?.text, let productTypeId = Int(productTypeIdText),
               let companyIdText = ProductPostCompanyIdField?.text, let companyId = Int(companyIdText),
               let productIdText = ProductPostProductIdField?.text, let productId = Int(productIdText),
//               let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
               let productPriceText = ProductPostPriceField?.text, let productPrice = Double(productPriceText),
               let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty
           else {
               let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
            let selectedDate = datePicker.date
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            // Check if company exists
            let companyFetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            companyFetchRequest.predicate = NSPredicate(format: "id == %@", String(companyId))
            do {
                let companies = try context.fetch(companyFetchRequest)
                if companies.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Check if product exists
            let productFetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            productFetchRequest.predicate = NSPredicate(format: "id == %ld", productId)
            do {
                let products = try context.fetch(productFetchRequest)
                if products.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Product ID does not exist", preferredStyle: .alert)
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
            // Check if product type exists
            let producttypeRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
            producttypeRequest.predicate = NSPredicate(format: "id == %ld", productTypeId)
            do {
                let producttypes = try context.fetch(producttypeRequest)
                if producttypes.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist", preferredStyle: .alert)
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
//            dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
//            guard let date = dateFormatter.date(from: productDateText) else {
//                let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//                return
//            }
        
        // Check if product Post already exists
        let postFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
        postFetchRequest.predicate = NSPredicate(format: "id == %ld", postId)
        do {
            let productPosts = try context.fetch(postFetchRequest)
            if productPosts.count > 0 {
                let alert = UIAlertController(title: "Error", message: "Product Post with the following already exists:\nID: \(postId)", preferredStyle: .alert)
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
        let newProductPost = ProductPostData(context: context)
        newProductPost.id = Int64(postId)
        newProductPost.product_type_id = Int64(productTypeId)
        newProductPost.company_id = Int64(companyId)
        newProductPost.product_id = Int64(productId)
        newProductPost.posted_date = selectedDate
        newProductPost.price = productPrice
        newProductPost.description_ = productDescription
            // Save changes
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Product Post added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            // Call the delegate method with the newly created product post
            delegate?.didAddProductPost(ProductPost: newProductPost)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func updateProductPost(_ sender: UIButton) {
        print("Update Product Post button pressed")
        guard let postIdText = ProductPostIdField?.text, let postId = Int(postIdText),
              let productTypeIdText = ProductPostProductTypeIdField?.text, let productTypeId = Int(productTypeIdText),
              let companyIdText = ProductPostCompanyIdField?.text, let companyId = Int(companyIdText),
              let productIdText = ProductPostProductIdField?.text, let productId = Int(productIdText),
//              let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
              let productPriceText = ProductPostPriceField?.text, let productPrice = Double(productPriceText),
              let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty
          else {
              let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
            let selectedDate = datePicker.date

           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
            // Check if company exists
            let companyFetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            companyFetchRequest.predicate = NSPredicate(format: "id == %@", String(companyId))
            do {
                let companies = try context.fetch(companyFetchRequest)
                if companies.count == 0 {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        // Check if product exists
        let productFetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        productFetchRequest.predicate = NSPredicate(format: "id == %ld", productId)
        do {
            let products = try context.fetch(productFetchRequest)
            if products.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Product ID does not exist", preferredStyle: .alert)
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
        // Check if product type exists
        let producttypeRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
        producttypeRequest.predicate = NSPredicate(format: "id == %ld", productTypeId)
        do {
            let producttypes = try context.fetch(producttypeRequest)
            if producttypes.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist", preferredStyle: .alert)
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
//        dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
//        guard let date = dateFormatter.date(from: productDateText) else {
//            let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            present(alert, animated: true, completion: nil)
//            return
//        }

        // Update the product Post
        let fetchRequestToUpdate: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
        fetchRequestToUpdate.predicate = NSPredicate(format: "id == %ld", postId)
    do {
            let result = try context.fetch(fetchRequestToUpdate)
            
            if let productPostToUpdate = result.first {
                productPostToUpdate.id = Int64(postId)
                productPostToUpdate.product_type_id = Int64(productTypeId)
                productPostToUpdate.company_id = Int64(companyId)
                productPostToUpdate.product_id = Int64(productId)
                productPostToUpdate.posted_date = selectedDate
                productPostToUpdate.price = productPrice
                productPostToUpdate.description_ = productDescription
                
                try context.save()
                
                let alert = UIAlertController(title: "Product Post Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                // Call the delegate method with the newly created product post
                delegate?.didUpdateProductPost(ProductPost: productPostToUpdate)
            } else {
                let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to update.", preferredStyle: .alert)
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
