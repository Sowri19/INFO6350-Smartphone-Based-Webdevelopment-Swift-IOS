//
//  ProductDetailsViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // Property to store the passed company
    var Product: ProductData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update the text of the UITextView
        if let product = Product {
            let text = "Product ID: \(product.id)\nProduct Name: \(product.name ?? "")\nProduct Description: \(product.product_description ?? "")\nRating: \(product.product_rating) \nQuantity: \(product.quantity)\nCompany ID: \(product.company_id)"
            textView.text = text
            
            // Update the image in the UIImageView
            if let imageData = product.logo, let image = UIImage(data: imageData) {
                logoImageView.image = image
                logoImageView.contentMode = .scaleAspectFill
            }
        }
    }

}
