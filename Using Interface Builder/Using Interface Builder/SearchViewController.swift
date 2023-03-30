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
        if let id = Int(SearchidField.text ?? "") {
            let vc = SearchViewController(nibName: "DisplaySearchedCompanyView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayCompanyDetails(id: id, textView: textView)
            }
        }
    }

    @IBAction func searchProduct(_ sender: UIButton) {
        print("submitProductSearch button pressed")
        if let id = Int(SearchidField.text ?? "") {
            let vc = SearchViewController(nibName: "DisplaySearchedProductView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayProductDetails(id: id, textView: textView)
            }
        }
    }

    @IBAction func searchProductPost(_ sender: UIButton) {
        print("submitProductPostSearch button pressed")
        if let id = Int(SearchidField.text ?? "") {
            let vc = SearchViewController(nibName: "DisplaySearchedProductPostView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayProductPostDetails(id: id, textView: textView)
            }
        }
    }

    @IBAction func searchRatings(_ sender: UIButton) {
       
        print("submitRatingSearch button pressed")
           if let rating = Double(RatingsField.text ?? "") {
               let vc = SearchViewController(nibName: "DisplaySearchedRatingsView", bundle: nil)
               self.present(vc, animated: true, completion: nil)
               if let textView = vc.textView {
                   displayRatingsDetails(rating: rating, textView: textView)
               }
           }
    }

    @IBAction func searchProductType(_ sender: UIButton) {
        print("submitProductTypeSearch button pressed")
        if let id = Int(SearchidField.text ?? "") {
            let vc = SearchViewController(nibName: "DisplaySearchedProductTypeView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayProductTypeDetails(id: id, textView: textView)
            }
        }
    }
    
    func displayProductTypeDetails(id: Int, textView: UITextView) {
        let productTypes = productManager.viewAllProductTypes()
        if let productType = productTypes.first(where: { $0.id == id }) {
            let productTypeString = "ID: \(productType.id)\nProduct Type: \(productType.product_type)\n"
            textView.text = productTypeString
        } else {
            textView.text = "Product type with ID \(id) not found"
        }
    }
    
    func displayCompanyDetails(id: Int, textView: UITextView) {
        let companies = productManager.viewAllCompanies()
        if let company = companies.first(where: { $0.id == id }) {
            let companyString = "ID: \(company.id)\nname: \(company.name)\naddress: \(company.address)\ncountry: \(company.country)\nzip: \(company.zip)\ncompany_type: \(company.company_type)"
            textView.text = companyString
        } else {
            textView.text = "Product type with ID \(id) not found"
        }
    }
    
    func displayProductDetails(id: Int, textView: UITextView) {
        let products = productManager.viewAllProducts()
        if let product = products.first(where: { $0.id == id }) {
            let productString = "ID: \(product.id)\nname: \(product.name)\nproduct_description: \(product.product_description)\nproduct_rating: \(product.product_rating)\ncompany_id: \(product.company_id)\nquantity: \(product.quantity)"
            textView.text = productString
        } else {
            textView.text = "Product type with ID \(id) not found"
        }
    }
    
    func displayProductPostDetails(id: Int, textView: UITextView) {
        let productPosts = productManager.viewAllProductPosts()
        if let productPost = productPosts.first(where: { $0.product_post_id == id }) {
            let productPostString = "ID: \(productPost.product_post_id)\nproduct_type_id: \(productPost.product_type_id)\ncompany_id: \(productPost.company_id)\nproduct_id: \(productPost.product_id)\nposted_date: \(productPost.posted_date)\nprice: \(productPost.price)\ndescription: \(productPost.description)"
            textView.text = productPostString
        } else {
            textView.text = "Product post with ID \(id) not found"
        }
    }
    
    func displayRatingsDetails(rating: Double, textView: UITextView) {
        let products = productManager.viewAllProducts()
        if let product = products.first(where: { Double($0.product_rating) == rating }) {
            let productString = "ID: \(product.id)\nname: \(product.name)\nproduct_description: \(product.product_description)\nproduct_rating: \(product.product_rating)\ncompany_id: \(product.company_id)\nquantity: \(product.quantity)"
            textView.text = productString
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
