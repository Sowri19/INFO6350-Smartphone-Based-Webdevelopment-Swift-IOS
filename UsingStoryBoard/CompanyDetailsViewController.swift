//
//  CompanyDetailsViewController.swift
//  UsingStoryBoard
//

import UIKit

class CompanyDetailsViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // Property to store the passed company
    var Company: CompanyData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update the text of the UITextView
        if let company = Company {
            let text = "Company ID: \(company.id)\nCompany Name: \(company.name ?? "")\nCompany Type: \(company.company_type ?? "")\nAddress: \(company.address ?? "")\nZip: \(company.zip)\nCountry: \(company.country ?? "")"
            textView.text = text
            
            // Update the image in the UIImageView
            if let imageData = company.logo, let image = UIImage(data: imageData) {
                logoImageView.image = image
                logoImageView.contentMode = .scaleAspectFill
            }
        }
    }
}

