//
//  ManageCompaniesViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit
import CoreData

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
        
        guard let idText = CompanyIdField?.text, let companyId = Int(idText),
              let companyName = CompanyNameField?.text, !companyName.isEmpty,
              let companyAddress = CompanyAddressField?.text, !companyAddress.isEmpty,
              let companyCountry =  CompanyCountryField?.text, !companyCountry.isEmpty,
              let companyZip = CompanyZipField?.text, let CompanyZip = Int(companyZip),
              let companyType = CompanyTypeField?.text, !companyType.isEmpty else {
            // handle case where required fields are empty
            let alert = UIAlertController(title: "Error", message: "Please fill out all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // check if a company with the same id or name already exists
        let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d OR name == %@", companyId, companyName)
        do {
            let existingCompanies = try context.fetch(fetchRequest)
            if !existingCompanies.isEmpty {
                var errorMessage = "A company with the following already exists:\n"
                if existingCompanies.contains(where: { $0.id == companyId }) {
                    errorMessage += "ID: \(companyId)"
                }
                if existingCompanies.contains(where: { $0.name == companyName }) {
                    errorMessage += "\nCompany Name: \(companyName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
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
        
        // create a new Company object and set its properties
        let newCompany = CompanyData(context: context)
        newCompany.id = Int64(companyId)
        newCompany.name = companyName
        newCompany.address = companyAddress
        newCompany.country = companyCountry
        newCompany.zip = Int64(CompanyZip)
        newCompany.company_type = companyType
        
        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Company added successfully", preferredStyle: .alert)
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
    
    @IBAction func DeleteCompany(_ sender: UIButton) {
        print("Delete Company button pressed")
           guard let idText = CompanyIdField.text, let companyId = Int(idText) else {
               let alert = UIAlertController(title: "Error", message: "Please enter a valid Company ID", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }

        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
        // Check if any product posts are associated with this company
        let productPostFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
        productPostFetchRequest.predicate = NSPredicate(format: "company_id == %ld", companyId)
        do {
            let productPosts = try context.fetch(productPostFetchRequest)
            if !productPosts.isEmpty {
                let alert = UIAlertController(title: "Error", message: "There are product posts associated with this company id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            // Handle any errors that occur during fetch
            let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with company with error: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        // Check if any products are associated with this product type
        let productFetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        productFetchRequest.predicate = NSPredicate(format: "company_id == %ld", companyId)
        
        do {
            let products = try context.fetch(productFetchRequest)
            if !products.isEmpty {
                let alert = UIAlertController(title: "Error", message: "There are products associated with this company id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch let error {
            // Handle any errors that occur during fetch
            let alert = UIAlertController(title: "Error", message: "Failed to fetch products associated with company with error: \(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
    // Now delete the company
       let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
       fetchRequest.predicate = NSPredicate(format: "id == %d", companyId)
       do {
           let result = try context.fetch(fetchRequest)
           if let companyToDelete = result.first {
               context.delete(companyToDelete)
               try context.save()

               let alert = UIAlertController(title: "Company Deleted Successfully", message: "Press OK to continue", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           } else {
               let alert = UIAlertController(title: "Error", message: "Company ID does not exist to delete.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
       } catch {
           let alert = UIAlertController(title: "Error", message: "Failed to delete company", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }
    }
    
    @IBAction func UpdateCompany(_ sender: UIButton) {
        print("Update Company button pressed")
        guard let idText = CompanyIdField.text, let companyId = Int(idText),
               let nameText = CompanyNameField.text, !nameText.isEmpty,
               let addressText = CompanyAddressField.text, !addressText.isEmpty,
               let countryText = CompanyCountryField.text, !countryText.isEmpty,
               let zipText = CompanyZipField.text, !zipText.isEmpty,
               let typeText = CompanyTypeField.text, !typeText.isEmpty
               else {
                   let alert = UIAlertController(title: "Error", message: "Please enter a valid Company ID, Name, Address, Country, Zip, and Type", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
                   return
           }
           
           let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %d", companyId)
           
           do {
               let result = try context.fetch(fetchRequest)
               
               if let companyToUpdate = result.first {
                   companyToUpdate.name = nameText
                   companyToUpdate.address = addressText
                   companyToUpdate.country = countryText
                   companyToUpdate.zip = Int64(zipText)!
                   companyToUpdate.company_type = typeText
                   
                   try context.save()
                   
                   let alert = UIAlertController(title: "Company Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               } else {
                   let alert = UIAlertController(title: "Error", message: "Company ID does not exist to update.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               }
           } catch {
               let alert = UIAlertController(title: "Error", message: "Failed to update company", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
    }
    
    func viewAllCompanies(textView: UITextView) {
        // Get the managed object context
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            do {
                // Create a fetch request for the CompanyData entity
                let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
                
                // Fetch all companies from Core Data
                let companies = try context.fetch(fetchRequest)
                
                // Construct a string with details of all companies
                var companyString = ""
                for company in companies {
                    companyString += "ID: \(company.id)\n"
                    companyString += "Name: \(company.name ?? "")\n"
                    companyString += "Country: \(company.country ?? "")\n"
                    companyString += "Address: \(company.address ?? "")\n"
                    companyString += "Zip: \(company.zip)\n"
                    companyString += "Type: \(company.company_type ?? "")\n\n"
                }
                
                // Set the string as the text for the given UITextView
                textView.text = companyString
            } catch {
                // Handle any errors that occur during fetch
                print("Failed to fetch companies: \(error.localizedDescription)")
                
                // Check if an alert is already being presented
                guard presentedViewController == nil else {
                    return
                }
                
                // Show an alert with the error message
                let alert = UIAlertController(title: "Error", message: "Failed to fetch companies.", preferredStyle: .alert)
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
