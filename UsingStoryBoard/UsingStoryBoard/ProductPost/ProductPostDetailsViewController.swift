//
//  ProductPostDetailsViewController.swift
//  UsingStoryBoard
//


import UIKit
import CoreData

class ProductPostDetailsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // Property to store the passed company
    var ProductPost: ProductPostData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update the text of the UITextView
        if let productPost = ProductPost {
            let text = "Post ID: \(productPost.id)\nProduct ID: \(productPost.product_id)\nProduct Type ID: \(productPost.product_type_id)\nPost Description: \(productPost.description_ ?? "")\nDate: \(productPost.posted_date ?? Date()) \nPrice: \(productPost.price)\nCompany ID: \(productPost.company_id)"
            textView.text = text

        }
    }

}
