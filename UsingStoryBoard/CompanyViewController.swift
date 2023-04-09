//
//  CompanyViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//

import UIKit
import CoreData

protocol CompanyViewControllerDelegate: AnyObject {
    func didAddCompany(Company: CompanyData)
    func didUpdateCompany(Company: CompanyData)
}

class CompanyViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var CompanyIdField: UITextField!
    @IBOutlet weak var CompanyNameField: UITextField!
    @IBOutlet weak var CompanyAddressField: UITextField!
    @IBOutlet weak var CompanyCountryField: UITextField!
    @IBOutlet weak var CompanyZipField: UITextField!
    @IBOutlet weak var CompanyTypeField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    weak var delegate: CompanyViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    
    @IBAction func pickImageButtonTapped(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            logoImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
        guard let imageData = logoImageView.image?.jpegData(compressionQuality: 1.0) else {
                    let alert = UIAlertController(title: "Error", message: "Failed to convert image to data", preferredStyle: .alert)
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
        newCompany.logo = imageData
        
        // save changes to Core Data
        do {
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Company added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            // Call the delegate method with the newly created company
            delegate?.didAddCompany(Company: newCompany)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
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
        guard let imageData = logoImageView.image?.jpegData(compressionQuality: 1.0) else {
                    let alert = UIAlertController(title: "Error", message: "Failed to convert image to data", preferredStyle: .alert)
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
                   companyToUpdate.logo = imageData
                   try context.save()
                   let alert = UIAlertController(title: "Company Updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
                   // Call the delegate method with the newly created company
                   delegate?.didUpdateCompany(Company: companyToUpdate)
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
}
