//
//  SearchViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var SearchidField: UITextField!
    @IBOutlet weak var RatingsField: UITextField!

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchCompanyButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchCompanyView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchProductButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchProductView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchProductPostButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchProductPostView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchRatingsButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchRatingsView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func searchProductTypeButtonTapped(_ sender: UIButton) {
        let vc = SearchViewController(nibName: "SearchProductTypeView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchCompany(_ sender: UIButton) {
        print("submitCompanySearch button pressed")
            guard let idText = SearchidField.text, !idText.isEmpty else {
                // show alert for empty field
                let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            guard let id = Int(idText) else {
                // show alert for invalid input
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let vc = SearchViewController(nibName: "DisplaySearchedCompanyView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayCompanyDetails(id: id, textView: textView)
            }
    }

    @IBAction func searchProduct(_ sender: UIButton) {
    print("submitProductSearch button pressed")
        guard let idString = SearchidField.text, !idString.isEmpty else {
            // Alert the user that the ID field is empty
            let alert = UIAlertController(title: "Missing Information", message: "Please enter a product ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        guard let id = Int(idString) else {
            // Alert the user that the ID field contains invalid input
            let alert = UIAlertController(title: "Error", message: "Please enter a valid product ID", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let vc = SearchViewController(nibName: "DisplaySearchedProductView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
        if let textView = vc.textView {
            displayProductDetails(id: id, textView: textView)
        }
    }

    @IBAction func searchProductPost(_ sender: UIButton) {
    print("submitProductPostSearch button pressed")
       guard let idText = SearchidField.text, !idText.isEmpty else {
           // show alert for empty field
           let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
           return
       }
       guard let id = Int(idText) else {
           // show alert for invalid data type
           let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer for ID.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
           return
       }
       let vc = SearchViewController(nibName: "DisplaySearchedProductPostView", bundle: nil)
       self.present(vc, animated: true, completion: nil)
       if let textView = vc.textView {
           displayProductPostDetails(id: id, textView: textView)
       }
    }

    @IBAction func searchRatings(_ sender: UIButton) {
        print("submitRatingSearch button pressed")
           guard let ratingText = RatingsField.text, !ratingText.isEmpty else {
               // show alert for empty field
               let alert = UIAlertController(title: "Missing Information", message: "Please enter a rating.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           guard let rating = Double(ratingText) else {
               // show alert for invalid input
               let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid rating.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           let vc = SearchViewController(nibName: "DisplaySearchedRatingsView", bundle: nil)
           self.present(vc, animated: true, completion: nil)
           
           if let textView = vc.textView {
               displayRatingsDetails(rating: rating, textView: textView)
           }
    }

    @IBAction func searchProductType(_ sender: UIButton) {
        print("submitProductTypeSearch button pressed")
           guard let idText = SearchidField.text, !idText.isEmpty else {
               // show alert for empty field
               let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           guard let id = Int(idText) else {
               // show alert for invalid input
               let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer for ID.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           let vc = SearchViewController(nibName: "DisplaySearchedProductTypeView", bundle: nil)
           self.present(vc, animated: true, completion: nil)
           if let textView = vc.textView {
               displayProductTypeDetails(id: id, textView: textView)
           }
    }
    
    func displayProductTypeDetails(id: Int, textView: UITextView) {
        let productTypes = productManager.viewAllProductTypes()
            if let productType = productTypes.first(where: { $0.id == id }) {
                var matchingPosts = [String]()
                for post in productManager.viewAllProductPosts() {
                    if post.product_type_id == productType.id {
                        let postString = "ID: \(post.product_post_id)\nproduct_id: \(post.product_id)\nprice: \(post.price)\ncompany_id: \(post.company_id)\nProduct Type ID: \(post.product_type_id)\nPosted Date: \(post.posted_date)\nDescription: \(post.description)\n\n"
                        matchingPosts.append(postString)
                    }
                }
                if !matchingPosts.isEmpty {
                    textView.text = matchingPosts.joined(separator: "")
                } else {
                    textView.text = "No product posts found for this product type"
                }
            } else {
                textView.text = "Product type with ID \(id) not found"
            }
    }
    
    func displayCompanyDetails(id: Int, textView: UITextView) {
        let companies = productManager.viewAllCompanies()
            if let company = companies.first(where: { $0.id == id }) {
                var matchingPosts = [String]()
                for post in productManager.viewAllProductPosts() {
                    if post.company_id == company.id {
                        let postString = "ID: \(post.product_post_id)\nproduct_id: \(post.product_id)\nprice: \(post.price)\ncompany_id: \(post.company_id)\nProduct Type ID: \(post.product_type_id)\nPosted Date: \(post.posted_date)\nDescription: \(post.description)\n\n"
                        matchingPosts.append(postString)
                    }
                }
                if !matchingPosts.isEmpty {
                    textView.text = matchingPosts.joined(separator: "")
                } else {
                    textView.text = "No product posts found for this company"
                }
            } else {
                textView.text = "Company with ID \(id) not found"
            }
    }
    
    func displayProductDetails(id: Int, textView: UITextView) {
        let products = productManager.viewAllProducts()
            if let product = products.first(where: { $0.id == id }) {
                var matchingPosts = [String]()
                for post in productManager.viewAllProductPosts() {
                    if post.product_id == product.id {
                        let postString = "ID: \(post.product_post_id)\nproduct_id: \(post.product_id)\nprice: \(post.price)\ncompany_id: \(post.company_id)\nProduct Type ID: \(post.product_type_id)\nPosted Date: \(post.posted_date)\nDescription: \(post.description)\n\n"
                        matchingPosts.append(postString)
                    }
                }
                if !matchingPosts.isEmpty {
                    textView.text = matchingPosts.joined(separator: "")
                } else {
                    textView.text = "No product posts found for this product"
                }
            } else {
                textView.text = "Product with ID \(id) not found"
            }
    }
    
    func displayProductPostDetails(id: Int, textView: UITextView) {
        let productPosts = productManager.viewAllProductPosts()
        if let productPost = productPosts.first(where: { $0.product_post_id == id }) {
            let productPostString = "ID: \(productPost.product_post_id)\nproduct_type_id: \(productPost.product_type_id)\ncompany_id: \(productPost.company_id)\nproduct_id: \(productPost.product_id)\nposted_date: \(productPost.posted_date)\nprice: \(productPost.price)\ndescription: \(productPost.description)\n\n"
            textView.text = productPostString
        } else {
            textView.text = "Product post with ID \(id) not found"
        }
    }
    
    func displayRatingsDetails(rating: Double, textView: UITextView) {
        let products = productManager.viewAllProducts()
            if let product = products.first(where: { Double($0.product_rating) == rating }) {
                var matchingPosts = [String]()
                for post in productManager.viewAllProductPosts() {
                    if post.product_id == product.id {
                        let postString = "ID: \(post.product_post_id)\nproduct_id: \(post.product_id)\nprice: \(post.price)\ncompany_id: \(post.company_id)\nProduct Type ID: \(post.product_type_id)\nPosted Date: \(post.posted_date)\nDescription: \(post.description)\n\n"
                        matchingPosts.append(postString)
                    }
                }
                if !matchingPosts.isEmpty {
                    textView.text = matchingPosts.joined(separator: "")
                } else {
                    textView.text = "No product posts found for this product type with rating \(rating)"
                }
            } else {
                textView.text = "Product type with rating \(rating) not found"
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
