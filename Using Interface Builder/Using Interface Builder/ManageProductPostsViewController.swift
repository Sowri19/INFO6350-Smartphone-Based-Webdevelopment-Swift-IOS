//
//  ManageProductPostsViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit
import CoreData

class ManageProductPostsViewController: UIViewController {

    @IBOutlet weak var ProductPostIdField: UITextField!
    @IBOutlet weak var ProductPostProductTypeIdField: UITextField!
    @IBOutlet weak var ProductPostCompanyIdField: UITextField!
    @IBOutlet weak var ProductPostProductIdField: UITextField!
    @IBOutlet weak var ProductPostPostedDateField: UITextField!
    @IBOutlet weak var ProductPostPriceField: UITextField!
    @IBOutlet weak var ProductPostDescriptionField: UITextField!
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func addProductPostButtonTapped(_ sender: UIButton) {
        let vc = ManageProductPostsViewController(nibName: "AddProductPostView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func deleteProductPostButtonTapped(_ sender: UIButton) {
        let vc = ManageProductPostsViewController(nibName: "DeleteProductPostView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateProductPostButtonTapped(_ sender: UIButton) {
        let vc = ManageProductPostsViewController(nibName: "UpdateProductPostView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllProductPostsButtonTapped(_ sender: UIButton) {
        let vc = ManageProductPostsViewController(nibName: "ViewAllProductPostsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
        if let textView = vc.textView {
            viewAllProductPosts(textView: textView)
                   }
    }


    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func addProductPost(_ sender: UIButton) {
        print("Add Product Post button pressed")
         guard let postIdText = ProductPostIdField?.text, let postId = Int(postIdText),
               let productTypeIdText = ProductPostProductTypeIdField?.text, let productTypeId = Int(productTypeIdText),
               let companyIdText = ProductPostCompanyIdField?.text, let companyId = Int(companyIdText),
               let productIdText = ProductPostProductIdField?.text, let productId = Int(productIdText),
               let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
               let productPriceText = ProductPostPriceField?.text, let productPrice = Double(productPriceText),
               let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty
           else {
               let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
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
            dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
            guard let date = dateFormatter.date(from: productDateText) else {
                let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        
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
        newProductPost.posted_date = date
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
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func deleteProductPost(_ sender: UIButton) {
        print("Delete Product Post button pressed")
        if let postIdText = ProductPostIdField?.text, let postDeleteId = Int(postIdText) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", postDeleteId)
            do {
                let results = try context.fetch(fetchRequest)
                if let postToDelete = results.first {
                    context.delete(postToDelete)
                    try context.save()
                    // Deletion was successful
                    let alert = UIAlertController(title: "Product Post Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    // Deletion failed
                    let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } catch {
                // handle error
                print("Error deleting product post: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to delete product post.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Please enter a valid Product Post ID", preferredStyle: .alert)
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
              let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
              let productPriceText = ProductPostPriceField?.text, let productPrice = Double(productPriceText),
              let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty
          else {
              let alert = UIAlertController(title: "Error", message: "Please fill all fields and ensure product rating is less than 5 or = 5", preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
              present(alert, animated: true, completion: nil)
              return
          }
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
        dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
        guard let date = dateFormatter.date(from: productDateText) else {
            let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }

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
                productPostToUpdate.posted_date = date
                productPostToUpdate.price = productPrice
                productPostToUpdate.description_ = productDescription
                
                try context.save()
                
                let alert = UIAlertController(title: "Product Post Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
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
   
    func viewAllProductPosts(textView: UITextView) {
        // Get the managed object context
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            // Create a fetch request for the PostData entity
            let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            
            // Fetch all posts from Core Data
            let posts = try context.fetch(fetchRequest)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            // Construct a string with details of all posts
            var postString = ""
            for post in posts {
                postString += "Post ID: \(post.id)\n"
                postString += "Product Type ID: \(post.product_type_id)\n"
                   postString += "Company ID: \(post.company_id)\n"
                   postString += "Product ID: \(post.product_id)\n"
                    if let postedDate = post.posted_date {
                           postString += "Posted Date: \(dateFormatter.string(from: postedDate))\n"
                       }
                   postString += "Price: \(post.price)\n"
                if let description = post.description_ {
                        postString += "Description: \(description)\n\n"
                    } else {
                        postString += "Description: N/A\n\n"
                    }
               }
            
            // Set the string as the text for the given UITextView
            textView.text = postString
        } catch {
            // Handle any errors that occur during fetch
            print("Failed to fetch posts: \(error.localizedDescription)")
            
            // Check if an alert is already being presented
            guard presentedViewController == nil else {
                return
            }
            
            // Show an alert with the error message
            let alert = UIAlertController(title: "Error", message: "Failed to fetch posts.", preferredStyle: .alert)
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
