//
//  ManageProductPostsViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit

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
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let postIdText = ProductPostIdField?.text, let postId = Int(postIdText),
           let productTypeIdText = ProductPostProductTypeIdField?.text, let productTypeId = Int(productTypeIdText),
           let companyIdText = ProductPostCompanyIdField?.text, let companyId = Int(companyIdText),
           let productIdText = ProductPostProductIdField?.text, let ProductId = Int(productIdText),let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
           let productPriceText = ProductPostPriceField?.text, let ProductPrice = Double(productPriceText), let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty {
            
            // Check if the product post already exists
            let productPostIDExists = productManager.productPosts.contains { $0.product_post_id == postId }
            if productPostIDExists {
                let alert = UIAlertController(title: "Error", message: "Product post with ID \(postId) already exists.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Check if the product type ID is valid
            if !productManager.productTypes.contains(where: { $0.id == productTypeId }) {
                let alert = UIAlertController(title: "Error", message: "Product type ID \(productTypeId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Check if the company ID is valid
            if !productManager.companies.contains(where: { $0.id == companyId }) {
                let alert = UIAlertController(title: "Error", message: "Company ID \(companyId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Check if the product ID is valid
            if !productManager.products.contains(where: { $0.id == ProductId }) {
                let alert = UIAlertController(title: "Error", message: "Product ID \(ProductId) is invalid.", preferredStyle: .alert)
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
            // Create a new product post and add it to the productPosts array
            let newProductPost = Product_Post(product_post_id: postId, product_type_id: productTypeId, company_id: companyId, product_id: ProductId, posted_date: date, price: ProductPrice, description: productDescription)
            productManager.addProductPost(productPost: newProductPost)
            
            let alert = UIAlertController(title: "Product Post Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func deleteProductPost(_ sender: UIButton) {
        print("Delete Product Post button pressed")
        if let postIdText = ProductPostIdField?.text, let postDeleteId = Int(postIdText){
            let productPostIDExists = productManager.productPosts.contains { $0.product_post_id == postDeleteId }
            if productPostIDExists {
                // Delete the product post from the productPosts array
                if let productPostToDelete = productManager.productPosts.first(where: { $0.product_post_id == postDeleteId }) {
                    productManager.deleteProductPost(productPost: productPostToDelete)
                    print("Product post deleted successfully!")
                    // Handle case where product post id is deleted
                    let alert = UIAlertController(title: "Success", message: "Product Post deleted successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func updateProductPost(_ sender: UIButton) {
        print("Update Product Post button pressed")
        //        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let postIdText = ProductPostIdField?.text, let postId = Int(postIdText),
           let productTypeIdText = ProductPostProductTypeIdField?.text, let productTypeId = Int(productTypeIdText),
           let companyIdText = ProductPostCompanyIdField?.text, let companyId = Int(companyIdText),
           let productIdText = ProductPostProductIdField?.text, let ProductId = Int(productIdText),let productDateText = ProductPostPostedDateField?.text, !productDateText.isEmpty,
           let productPriceText = ProductPostPriceField?.text, let ProductPrice = Double(productPriceText), let productDescription = ProductPostDescriptionField?.text, !productDescription.isEmpty {
            
            // Check if the product post already exists
            let productPostIDExists = productManager.productPosts.contains { $0.product_post_id == postId }
            if productPostIDExists {
                // Check if the product type ID is valid
                if !productManager.productTypes.contains(where: { $0.id == productTypeId }) {
                    let alert = UIAlertController(title: "Error", message: "Product type ID \(productTypeId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                // Check if the company ID is valid
                if !productManager.companies.contains(where: { $0.id == companyId }) {
                    let alert = UIAlertController(title: "Error", message: "Company ID \(companyId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                // Check if the product ID is valid
                if !productManager.products.contains(where: { $0.id == ProductId }) {
                    let alert = UIAlertController(title: "Error", message: "Product ID \(ProductId) is invalid.", preferredStyle: .alert)
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
                // Create a new product post and add it to the productPosts array
                let newProductPost = Product_Post(product_post_id: postId, product_type_id: productTypeId, company_id: companyId, product_id: ProductId, posted_date: date, price: ProductPrice, description: productDescription)
                productManager.updateProductPost(productPost: newProductPost)
                
                let alert = UIAlertController(title: "Product Post updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            else{
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    @IBAction func viewAllProductPosts(_ sender: UIButton) {
        print("view all product posts pressed")
        let productPosts = productManager.viewAllProductPosts()
        
        // Create a new view to display the product posts
        let allProductPostsView = UIView(frame: UIScreen.main.bounds)
        allProductPostsView.backgroundColor = .systemTeal
        
        if productPosts.isEmpty {
            // Add a placeholder label if there are no product posts
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No product posts available"
            label.textColor = .black
            allProductPostsView.addSubview(label)
        } else {
            // Add a label for each product post
            var yOffset: CGFloat = 50.0 // starting y offset
            for productPost in productPosts {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "ID: \(productPost.product_post_id)"
                idLabel.textColor = .black
                allProductPostsView.addSubview(idLabel)
                
                let productTypeIDLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                productTypeIDLabel.text = "Prod Type ID: \(productPost.product_type_id)"
                productTypeIDLabel.textColor = .black
                allProductPostsView.addSubview(productTypeIDLabel)
                
                let companyIDLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 60.0, width: UIScreen.main.bounds.width - 40, height: 30))
                companyIDLabel.text = "Company ID: \(productPost.company_id)"
                companyIDLabel.textColor = .black
                allProductPostsView.addSubview(companyIDLabel)
                
                let productIDLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 90.0, width: UIScreen.main.bounds.width - 40, height: 30))
                productIDLabel.text = "Product ID: \(productPost.product_id)"
                productIDLabel.textColor = .black
                allProductPostsView.addSubview(productIDLabel)
                
                let postedDateLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                postedDateLabel.text = "Date: \(productPost.posted_date)"
                postedDateLabel.textColor = .black
                allProductPostsView.addSubview(postedDateLabel)
                
                let priceLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 150.0, width: UIScreen.main.bounds.width - 40, height: 30))
                priceLabel.text = "Price: \(productPost.price)"
                priceLabel.textColor = .black
                allProductPostsView.addSubview(priceLabel)
                
                let PostDescriptionLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 180.0, width: UIScreen.main.bounds.width - 40, height: 30))
                PostDescriptionLabel.text = "Description: \(productPost.description)"
                PostDescriptionLabel.textColor = .black
                allProductPostsView.addSubview(PostDescriptionLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 210))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allProductPostsView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 230.0 // increment y offset for next label
            }
        }
    }
   
    func viewAllProductPosts(textView: UITextView) {
        let productPosts = productManager.viewAllProductPosts()
        var productPostsString = ""
        for productPost in productPosts {
            productPostsString += "Product Post ID: \(productPost.product_post_id)\n"
            productPostsString += "Company ID: \(productPost.company_id)\n"
            productPostsString += "Product Type ID: \(productPost.product_type_id)\n"
            productPostsString += "Product ID: \(productPost.product_id)\n"
            productPostsString += "Description: \(productPost.description)\n"
            productPostsString += "Posted Date: \(productPost.posted_date)\n"
            productPostsString += "Price: \(productPost.price)\n\n"
        }
        textView.text = productPostsString
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
