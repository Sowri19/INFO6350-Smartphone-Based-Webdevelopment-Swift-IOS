//
//  ManageCompaniesViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit

class ManageCompaniesViewController: UIViewController {

    @IBOutlet weak var CompanyIdField: UITextField!
    @IBOutlet weak var CompanyNameField: UITextField!
    @IBOutlet weak var CompanyAddressField: UITextField!
    @IBOutlet weak var CompanyCountryField: UITextField!
    @IBOutlet weak var CompanyZipField: UITextField!
    @IBOutlet weak var CompanyTypeField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCompanyButtonTapped(_ sender: UIButton) {
        let vc = ManageCompaniesViewController(nibName: "AddCompanyView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func deleteCompanyButtonTapped(_ sender: UIButton) {
        let vc = ManageCompaniesViewController(nibName: "DeleteCompanyView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func updateCompanyButtonTapped(_ sender: UIButton) {
        let vc = ManageCompaniesViewController(nibName: "UpdateCompanyView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func viewAllCompaniesButtonTapped(_ sender: UIButton) {
        let vc = ManageProductTypesViewController(nibName: "ViewAllCompaniesView", bundle: nil)
                    self.present(vc, animated: true, completion: nil)
                if let textView = vc.TextView {
                    viewAllCompanies(textView: textView)
                    }
        }

    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func AddCompany(_ sender: UIButton) {
        print("Add Company button pressed")
        if let idText = CompanyIdField?.text, let companyId = Int(idText) ,let companyName = CompanyNameField?.text, !companyName.isEmpty,
           let companyAddress = CompanyAddressField?.text, !companyAddress.isEmpty, let companyCountry =  CompanyCountryField?.text, !companyCountry.isEmpty, let companyZip = CompanyZipField?.text, !companyZip.isEmpty, let companyType = CompanyTypeField?.text, !companyType.isEmpty {
            
            let productTypeExists = productManager.companies.contains { $0.id == companyId || $0.name == companyName}
            if productTypeExists {
                var errorMessage = "Company with the following already exists:\n"
                if productManager.companies.contains(where: { $0.id == companyId }) {
                    errorMessage += "ID: \(companyId)"
                }
                if productManager.companies.contains(where: { $0.name == companyName }) {
                    errorMessage += "\nCompany Name: \(companyName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            
            let newCompany = Company(id: companyId, name: companyName, address: companyAddress, country: companyCountry, zip: companyZip, company_type:companyType)
            productManager.addCompany(company: newCompany)
            let alert = UIAlertController(title: "Company Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    }
    @IBAction func DeleteCompany(_ sender: UIButton) {
        print("Delete Company button pressed")
            if let idText = CompanyIdField?.text, let companyId = Int(idText) {
                let companyToDelete = Company(id: companyId, name: "", address: "", country: "", zip: "", company_type: "")
                if productManager.deleteCompany(company: companyToDelete) {
                    // Deletion was successful
                    let alert = UIAlertController(title: "Company Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    // Deletion failed
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist to delete.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // handle case where idField has no text or the text is not a valid integer
                let alert = UIAlertController(title: "Error", message: "Please enter a valid Company ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    @IBAction func UpdateCompany(_ sender: UIButton) {
        print("Update Company button pressed")
            if let idText = CompanyIdField?.text, let companyId = Int(idText), let nameText = CompanyNameField?.text, !nameText.isEmpty,
               let addressText = CompanyAddressField?.text, !addressText.isEmpty,
               let countryText = CompanyCountryField?.text, !countryText.isEmpty,
               let zipText = CompanyZipField?.text, !zipText.isEmpty,
               let typeText = CompanyTypeField?.text, !typeText.isEmpty {
                
                let companyToUpdate = Company(id: companyId, name: nameText, address: addressText, country: countryText, zip: zipText, company_type: typeText)
                if productManager.updateCompany(company: companyToUpdate) {
                    let alert = UIAlertController(title: "Company Updated Successfully", message: "Press ok to continue", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                } else {
                    let alert = UIAlertController(title: "Error", message: "Company ID does not exist to update.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // handle case where any field has no text
                let alert = UIAlertController(title: "Error", message: "Please enter a valid Company ID, Name, Address, Country, Zip, and Type", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    func viewAllCompanies(textView: UITextView) {
        print("Delete Company button pressed")
        let companies = productManager.viewAllCompanies()
        var companyString = ""
        for company in companies {
            companyString += "ID: \(company.id)\n"
            companyString += "Name: \(company.name)\n"
            companyString += "Country: \(company.country)\n"
            companyString += "Address: \(company.address)\n"
            companyString += "Zip: \(company.zip)\n"
            companyString += "Type: \(company.company_type)\n\n"
        }
        textView.text = companyString
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
