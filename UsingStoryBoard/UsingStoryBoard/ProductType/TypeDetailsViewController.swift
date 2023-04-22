//
//  TypeDetailsViewController.swift
//  UsingStoryBoard
//


import UIKit

class TypeDetailsViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var logotype: UIImageView!
    
    // Property to store the passed product type
       var productType: Producttype? // Property to store the passed product type
       
       override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)

           // Update the text of the UITextView
           if let productType = productType {
               let text = "Product ID: \(productType.id)\n Product Type: \(productType.product_type ?? "")"
               textview.text = text
               
               // Update the image in the UIImageView
               if let imageData = productType.logo, let image = UIImage(data: imageData) {
                   logotype.image = image
                   logotype.contentMode = .scaleAspectFill
               }
           }
       }
   }
