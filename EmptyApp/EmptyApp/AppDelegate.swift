//
//  AppDelegate.swift
//  EmptyApp
//
//  Created by rab on 02/15/21.
//  Copyright © 2021 rab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITextFieldDelegate {
    
    var window: UIWindow?
    
    //  declare properties for each field
    var backButton: UIView?
    
    //  Product Type Declarations
    var ProductTypeIdField: UITextField!
    var ProductTypeField: UITextField!
    
    //  Company Declarations
    var CompanyIdField: UITextField!
    var CompanyNameField: UITextField!
    var CompanyAddressField: UITextField!
    var CompanyCountryField: UITextField!
    var CompanyZipField: UITextField!
    var CompanyTypeField: UITextField!
    
    // Product Declarations
    var ProductIdField: UITextField!
    var ProductNameField: UITextField!
    var ProductDescriptionField: UITextField!
    var ProductRatingField: UITextField!
    var ProductCompanyIdField: UITextField!
    var ProductQuantityField: UITextField!
    
    //  Product Post Declaration
    var ProductPostIdField: UITextField!
    var ProductPostProductTypeIdField: UITextField!
    var ProductPostCompanyIdField: UITextField!
    var ProductPostProductIdField: UITextField!
    var ProductPostPostedDateField: UITextField!
    var ProductPostPriceField: UITextField!
    var ProductPostDescriptionField: UITextField!
    var dateFormatter = DateFormatter()
    
    // Search Declarations
    var ProductSearchField: UITextField!
    var ProductTypeSearchField: UITextField!
    var ProductPostSearchField: UITextField!
    var companySearchField: UITextField!
    var ratingSearchField: UITextField!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.lightGray
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
            
            let addButton = UIButton(type: .system)
            addButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
            addButton.setTitle("Add a Product", for: .normal)
            addButton.addTarget(self, action: #selector(addProductButtonTapped), for: .touchUpInside)
            addButton.layer.cornerRadius = 5.0 // Set corner radius to 5.0 points
            addButton.layer.borderWidth = 1.0 // Set border width to 1.0 points
            addButton.layer.borderColor = UIColor.black.cgColor // Set border color to black
            addButton.backgroundColor = UIColor.white // Set background color to white
            window.addSubview(addButton)
            
            let viewAllProductsButton = UIButton(type: .system)
            viewAllProductsButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
            viewAllProductsButton.setTitle("View All Products", for: .normal)
            viewAllProductsButton.addTarget(self, action: #selector(viewAllProductsButtonTapped), for: .touchUpInside)
            viewAllProductsButton.layer.cornerRadius = 5.0
            viewAllProductsButton.layer.borderWidth = 1.0
            viewAllProductsButton.layer.borderColor = UIColor.black.cgColor
            viewAllProductsButton.backgroundColor = UIColor.white
            window.addSubview(viewAllProductsButton)
            
            let addCompanyButton = UIButton(type: .system)
            addCompanyButton.frame = CGRect(x: 20, y: 250, width: UIScreen.main.bounds.width - 40, height: 30)
            addCompanyButton.setTitle("Add a Company", for: .normal)
            addCompanyButton.addTarget(self, action: #selector(addCompanyButtonTapped), for: .touchUpInside)
            addCompanyButton.backgroundColor = UIColor.white
            addCompanyButton.layer.cornerRadius = 5
            addCompanyButton.layer.borderWidth = 1
            addCompanyButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(addCompanyButton)
            
            let deleteCompanyButton = UIButton(type: .system)
            deleteCompanyButton.frame = CGRect(x: 20, y: 300, width: UIScreen.main.bounds.width - 40, height: 30)
            deleteCompanyButton.setTitle("Delete a Company", for: .normal)
            deleteCompanyButton.addTarget(self, action: #selector(deleteCompanyButtonTapped), for: .touchUpInside)
            deleteCompanyButton.backgroundColor = UIColor.white
            deleteCompanyButton.layer.cornerRadius = 5.0
            deleteCompanyButton.layer.borderWidth = 1.0
            deleteCompanyButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(deleteCompanyButton)
            
            // Add a product type button
            let addProductTypeButton = UIButton(type: .system)
            addProductTypeButton.frame = CGRect(x: 20, y: 350, width: UIScreen.main.bounds.width - 40, height: 30)
            addProductTypeButton.setTitle("Add Product Type", for: .normal)
            addProductTypeButton.addTarget(self, action: #selector(addProductTypeButtonTapped), for: .touchUpInside)
            addProductTypeButton.backgroundColor = UIColor.white
            addProductTypeButton.layer.cornerRadius = 5.0
            addProductTypeButton.layer.borderWidth = 1.0
            addProductTypeButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(addProductTypeButton)
            
            let deleteProductTypeButton = UIButton(type: .system)
            deleteProductTypeButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
            deleteProductTypeButton.setTitle("Delete a Product Type", for: .normal)
            deleteProductTypeButton.addTarget(self, action: #selector(deleteProductTypeButtonTapped), for: .touchUpInside)
            deleteProductTypeButton.backgroundColor = UIColor.white
            deleteProductTypeButton.layer.cornerRadius = 5.0
            deleteProductTypeButton.layer.borderWidth = 1.0
            deleteProductTypeButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(deleteProductTypeButton)
            
            let viewAllCompaniesButton = UIButton(type: .system)
            viewAllCompaniesButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
            viewAllCompaniesButton.setTitle("View All Companies", for: .normal)
            viewAllCompaniesButton.addTarget(self, action: #selector(viewAllCompaniesButtonTapped), for: .touchUpInside)
            viewAllCompaniesButton.backgroundColor = UIColor.white
            viewAllCompaniesButton.layer.cornerRadius = 5.0
            viewAllCompaniesButton.layer.borderWidth = 1.0
            viewAllCompaniesButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(viewAllCompaniesButton)
            
            let viewProductTypesButton = UIButton(type: .system)
            viewProductTypesButton.frame = CGRect(x: 20, y: 500, width: UIScreen.main.bounds.width - 40, height: 30)
            viewProductTypesButton.setTitle("View All Product Types", for: .normal)
            viewProductTypesButton.addTarget(self, action: #selector(viewProductTypesButtonTapped), for: .touchUpInside)
            viewProductTypesButton.backgroundColor = UIColor.white
            viewProductTypesButton.layer.cornerRadius = 5
            viewProductTypesButton.layer.borderWidth = 1
            viewProductTypesButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(viewProductTypesButton)
            
            let managePostsButton = UIButton(type: .system)
            managePostsButton.frame = CGRect(x: 20, y: 550, width: UIScreen.main.bounds.width - 40, height: 30)
            managePostsButton.setTitle("Manage Product Posts", for: .normal)
            managePostsButton.addTarget(self, action: #selector(managePostsButtonTapped), for: .touchUpInside)
            managePostsButton.backgroundColor = UIColor.white
            managePostsButton.layer.cornerRadius = 5
            managePostsButton.layer.borderWidth = 1
            managePostsButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(managePostsButton)
            
            let searchButton = UIButton(type: .system)
            searchButton.frame = CGRect(x: 20, y: 600, width: UIScreen.main.bounds.width - 40, height: 30)
            searchButton.setTitle("Search", for: .normal)
            searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
            searchButton.layer.cornerRadius = 5.0
            searchButton.layer.borderWidth = 1
            searchButton.backgroundColor = UIColor.white
            searchButton.layer.borderColor = UIColor.black.cgColor
            window.addSubview(searchButton)
            
        }
        
        return true
    }
    
    @objc func deleteProductTypeButtonTapped() {
        // create new view
        let deleteProductType = UIView(frame: UIScreen.main.bounds)
        deleteProductType.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        deleteProductType.addSubview(idLabel)
        
        let idField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        idField.borderStyle = .roundedRect
        idField.keyboardType = .numberPad  // only accept numeric input
        deleteProductType.addSubview(idField)
        
        //         add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Delete Product Type", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        //        submitButton.addTarget(self, action: #selector(submitProduct), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        deleteProductType.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        deleteProductType.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(deleteProductType)
    }
    
    // All Product Type Functions
    @objc func addProductTypeButtonTapped() {
        
        // create new view
        let productTypeView = UIView(frame: UIScreen.main.bounds)
        productTypeView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        productTypeView.addSubview(idLabel)
        
        ProductTypeIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductTypeIdField.borderStyle = .roundedRect
        ProductTypeIdField.keyboardType = .numberPad  // only accept numeric input
        productTypeView.addSubview(ProductTypeIdField)
        
        let ProductTypeLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        ProductTypeLabel.text = "Type:"
        productTypeView.addSubview(ProductTypeLabel)
        
        ProductTypeField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductTypeField.borderStyle = .roundedRect
        productTypeView.addSubview(ProductTypeField)
        
        // add submit button
        let addProductType = UIButton(type: .system)
        addProductType.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        addProductType.setTitle("Add Product Type", for: .normal)
        addProductType.setTitleColor(.black, for: .normal)
        addProductType.addTarget(self, action: #selector(AddProductType), for: .touchUpInside)
        addProductType.backgroundColor = UIColor.green
        addProductType.layer.cornerRadius = 5
        addProductType.layer.borderWidth = 1
        addProductType.layer.borderColor = UIColor.black.cgColor
        productTypeView.addSubview(addProductType)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 250, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productTypeView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(productTypeView)
    }
    
    @objc func AddProductType() {
        print("Add Product Type button pressed")
        if let idText = ProductTypeIdField?.text, let productTypeId = Int(idText) ,let productType = ProductTypeField?.text, !productType.isEmpty {
            let productTypeExists = productManager.productTypes.contains { $0.id == productTypeId || $0.product_type == productType}
            if productTypeExists {
                var errorMessage = "A product type with the following already exists:\n"
                if productManager.productTypes.contains(where: { $0.id == productTypeId }) {
                    errorMessage += "ID: \(productTypeId)"
                }
                if productManager.productTypes.contains(where: { $0.product_type == productType }) {
                    errorMessage += "\nProduct Type: \(productType)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let newProductType = Product_type(id: productTypeId, product_type: productType)
            productManager.addProductType(productType: newProductType)
            let alert = UIAlertController(title: "Product Type Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func viewProductTypesButtonTapped() {
        let productTypes = productManager.viewAllProductTypes()
        // Create a new view to display the product types
        let allProductTypeView = UIView(frame: UIScreen.main.bounds)
        allProductTypeView.backgroundColor = .systemTeal
        
        if productTypes.isEmpty {
            // Add a placeholder label if there are no product types
            let label = UILabel(frame: CGRect(x: 90, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No product types available"
            label.textColor = .black
            allProductTypeView.addSubview(label)
        } else {
            // Add a label for each product type
            var yOffset: CGFloat = 50.0 // starting y offset
            for productType in productTypes {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "ID: \(productType.id)"
                idLabel.textColor = .black
                allProductTypeView.addSubview(idLabel)
                
                let typeLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                typeLabel.text = "Product Type: \(productType.product_type)"
                typeLabel.textColor = .black
                allProductTypeView.addSubview(typeLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 60))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allProductTypeView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 70.0 // increment y offset for next label
            }
        }
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allProductTypeView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(allProductTypeView)
    }
    
    @objc func deleteProductTypesButtonTapped() {
        // create new view
        let CompanyDeleteView = UIView(frame: UIScreen.main.bounds)
        CompanyDeleteView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        CompanyDeleteView.addSubview(idLabel)
        
        let idField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        idField.borderStyle = .roundedRect
        idField.keyboardType = .numberPad  // only accept numeric input
        CompanyDeleteView.addSubview(idField)
        
        //         add submit button
        let deleteCompany = UIButton(type: .system)
        deleteCompany.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        deleteCompany.setTitle("Delete Company", for: .normal)
        deleteCompany.setTitleColor(.black, for: .normal)
        //        deleteCompany.addTarget(self, action: #selector(submitProduct), for: .touchUpInside)
        deleteCompany.backgroundColor = UIColor.green
        deleteCompany.layer.cornerRadius = 5
        deleteCompany.layer.borderWidth = 1
        deleteCompany.layer.borderColor = UIColor.black.cgColor
        CompanyDeleteView.addSubview(deleteCompany)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        CompanyDeleteView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(CompanyDeleteView)
        
    }
    
    // All Company Functions
    @objc func addCompanyButtonTapped() {
        // create new view
        let CompanyView = UIView(frame: UIScreen.main.bounds)
        CompanyView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        CompanyView.addSubview(idLabel)
        
        CompanyIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyIdField.borderStyle = .roundedRect
        CompanyIdField.keyboardType = .numberPad  // only accept numeric input
        CompanyView.addSubview(CompanyIdField)
        
        let CompanyNameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        CompanyNameLabel.text = "Name:"
        CompanyView.addSubview(CompanyNameLabel)
        
        CompanyNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyNameField.borderStyle = .roundedRect
        CompanyView.addSubview(CompanyNameField)
        
        let CompanyAddressLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        CompanyAddressLabel.text = "Address:"
        CompanyView.addSubview(CompanyAddressLabel)
        
        CompanyAddressField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyAddressField.borderStyle = .roundedRect
        CompanyView.addSubview(CompanyAddressField)
        
        let CompanyCountryLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        CompanyCountryLabel.text = "Country:"
        CompanyView.addSubview(CompanyCountryLabel)
        
        CompanyCountryField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyCountryField.borderStyle = .roundedRect
        CompanyView.addSubview(CompanyCountryField)
        
        let CompanyZipLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 300, height: 30))
        CompanyZipLabel.text = "Zip:"
        CompanyView.addSubview(CompanyZipLabel)
        
        CompanyZipField = UITextField(frame: CGRect(x: 120, y: 300, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyZipField.borderStyle = .roundedRect
        CompanyView.addSubview(CompanyZipField)
        
        let CompanyTypeLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 300, height: 30))
        CompanyTypeLabel.text = "Company Type:"
        CompanyView.addSubview(CompanyTypeLabel)
        
        CompanyTypeField = UITextField(frame: CGRect(x: 120, y: 350, width: UIScreen.main.bounds.width - 140, height: 30))
        CompanyTypeField.borderStyle = .roundedRect
        CompanyView.addSubview(CompanyTypeField)
        
        // add submit button
        let addCompanyButton = UIButton(type: .system)
        addCompanyButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addCompanyButton.setTitle("Add Company", for: .normal)
        addCompanyButton.setTitleColor(.black, for: .normal)
        addCompanyButton.addTarget(self, action: #selector(AddCompany), for: .touchUpInside)
        addCompanyButton.backgroundColor = UIColor.green
        addCompanyButton.layer.cornerRadius = 5
        addCompanyButton.layer.borderWidth = 1
        addCompanyButton.layer.borderColor = UIColor.black.cgColor
        CompanyView.addSubview(addCompanyButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        CompanyView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(CompanyView)
    }
    
    @objc func AddCompany() {
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
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let newCompany = Company(id: companyId, name: companyName, address: companyAddress, country: companyCountry, zip: companyZip, company_type:companyType)
            productManager.addCompany(company: newCompany)
            let alert = UIAlertController(title: "Company Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func viewAllCompaniesButtonTapped() {
        let companies = productManager.viewAllCompanies()
        // Create a new view to display the companies
        let allCompaniesView = UIView(frame: UIScreen.main.bounds)
        allCompaniesView.backgroundColor = .systemTeal
        
        if companies.isEmpty {
            // Add a placeholder label if there are no companies
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No companies available"
            label.textColor = .black
            allCompaniesView.addSubview(label)
        } else {
            // Add a label for each company
            var yOffset: CGFloat = 50.0 // starting y offset
            for company in companies {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "ID: \(company.id)"
                idLabel.textColor = .black
                allCompaniesView.addSubview(idLabel)
                
                let nameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                nameLabel.text = "Name: \(company.name)"
                nameLabel.textColor = .black
                allCompaniesView.addSubview(nameLabel)
                
                let addressLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 60.0, width: UIScreen.main.bounds.width - 40, height: 30))
                addressLabel.text = "Address: \(company.address)"
                addressLabel.textColor = .black
                allCompaniesView.addSubview(addressLabel)
                
                let countryLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 90.0, width: UIScreen.main.bounds.width - 40, height: 30))
                countryLabel.text = "Country: \(company.country)"
                countryLabel.textColor = .black
                allCompaniesView.addSubview(countryLabel)
                
                let zipLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                zipLabel.text = "Zip: \(company.zip)"
                zipLabel.textColor = .black
                allCompaniesView.addSubview(zipLabel)
                
                let CompanyTypeLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 150.0, width: UIScreen.main.bounds.width - 40, height: 30))
                CompanyTypeLabel.text = "Company Type: \(company.company_type)"
                CompanyTypeLabel.textColor = .black
                allCompaniesView.addSubview(CompanyTypeLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 180))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allCompaniesView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 200.0 // increment y offset for next label
            }
        }
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allCompaniesView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(allCompaniesView)
    }
    
    @objc func deleteCompanyButtonTapped() {
        // create new view
        let CompanyDeleteView = UIView(frame: UIScreen.main.bounds)
        CompanyDeleteView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        CompanyDeleteView.addSubview(idLabel)
        
        let idField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        idField.borderStyle = .roundedRect
        idField.keyboardType = .numberPad  // only accept numeric input
        CompanyDeleteView.addSubview(idField)
        
        //         add submit button
        let deleteCompany = UIButton(type: .system)
        deleteCompany.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        deleteCompany.setTitle("Delete Company", for: .normal)
        deleteCompany.setTitleColor(.black, for: .normal)
        //        deleteCompany.addTarget(self, action: #selector(submitProduct), for: .touchUpInside)
        deleteCompany.backgroundColor = UIColor.green
        deleteCompany.layer.cornerRadius = 5
        deleteCompany.layer.borderWidth = 1
        deleteCompany.layer.borderColor = UIColor.black.cgColor
        CompanyDeleteView.addSubview(deleteCompany)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        CompanyDeleteView.addSubview(backButton)
        
        // add the product type view to the window
        window?.addSubview(CompanyDeleteView)
        
    }
    // All Product Functions
    
    @objc func addProductButtonTapped() {
        // create new view
        let productView = UIView(frame: UIScreen.main.bounds)
        productView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        productView.addSubview(idLabel)
        
        ProductIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductIdField.borderStyle = .roundedRect
        ProductIdField.keyboardType = .numberPad  // only accept numeric input
        productView.addSubview(ProductIdField)
        
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        nameLabel.text = "Name:"
        productView.addSubview(nameLabel)
        
        ProductNameField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductNameField.borderStyle = .roundedRect
        productView.addSubview(ProductNameField)
        
        let descriptionLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        descriptionLabel.text = "Description:"
        productView.addSubview(descriptionLabel)
        
        ProductDescriptionField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductDescriptionField.borderStyle = .roundedRect
        productView.addSubview(ProductDescriptionField)
        
        let ratingLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        ratingLabel.text = "Rating:"
        productView.addSubview(ratingLabel)
        
        ProductRatingField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductRatingField.borderStyle = .roundedRect
        productView.addSubview(ProductRatingField)
        
        let companyLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 30))
        companyLabel.text = "Company ID:"
        productView.addSubview(companyLabel)
        
        ProductCompanyIdField = UITextField(frame: CGRect(x: 120, y: 300, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductCompanyIdField.borderStyle = .roundedRect
        ProductCompanyIdField.keyboardType = .numberPad
        productView.addSubview(ProductCompanyIdField)
        
        let quantityLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 100, height: 30))
        quantityLabel.text = "Quantity:"
        productView.addSubview(quantityLabel)
        
        ProductQuantityField = UITextField(frame: CGRect(x: 120, y: 350, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductQuantityField.borderStyle = .roundedRect
        productView.addSubview(ProductQuantityField)
        
        //         add submit button
        let addProductButton = UIButton(type: .system)
        addProductButton.frame = CGRect(x: 20, y: 400, width: UIScreen.main.bounds.width - 40, height: 30)
        addProductButton.setTitle("Add Product", for: .normal)
        addProductButton.setTitleColor(.black, for: .normal)
        addProductButton.addTarget(self, action: #selector(AddProduct), for: .touchUpInside)
        addProductButton.backgroundColor = UIColor.green
        addProductButton.layer.cornerRadius = 5
        addProductButton.layer.borderWidth = 1
        addProductButton.layer.borderColor = UIColor.black.cgColor
        productView.addSubview(addProductButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productView.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(productView)
    }
    
    @objc func AddProduct() {
        print("Add Product button pressed")
        if let idText = ProductIdField?.text, let productId = Int(idText) ,let productName = ProductNameField?.text, !productName.isEmpty,
           let productDescription = ProductDescriptionField?.text, !productDescription.isEmpty, let productRating =  ProductRatingField?.text, let ProductRating = Double(productRating), let productCompanyId = ProductCompanyIdField?.text, let ProductCompanyId = Int(productCompanyId), let productQuantity = ProductQuantityField?.text, let ProductQuantity = Int(productQuantity)
        {
            let productTypeExists = productManager.products.contains { $0.id == productId || $0.name == productName}
            if productTypeExists {
                var errorMessage = "Product with the following already exists:\n"
                if productManager.products.contains(where: { $0.id == productId }) {
                    errorMessage += "ID: \(productId)"
                }
                if productManager.products.contains(where: { $0.name == productName }) {
                    errorMessage += "\nProduct Name: \(productName)"
                }
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let companyExists = productManager.companies.contains { $0.id == ProductCompanyId }
            if !companyExists {
                let alert = UIAlertController(title: "Error", message: "Company ID does not exist", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            if ProductRating > 5 {
                let alert = UIAlertController(title: "Error", message: "Rating must be between 1 and 5", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            let newProduct = Product(id: productId, name: productName, product_description: productDescription, product_rating: ProductRating, company_id: ProductCompanyId, quantity: ProductQuantity)
            productManager.addProduct(product: newProduct)
            let alert = UIAlertController(title: "Product Added Successfully", message: "Press ok to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Fields are empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func viewAllProductsButtonTapped() {
        let products = productManager.viewAllProducts()
        // Create a new view to display the products
        let allProductsView = UIView(frame: UIScreen.main.bounds)
        allProductsView.backgroundColor = .systemTeal
        
        if products.isEmpty {
            // Add a placeholder label if there are no products
            let label = UILabel(frame: CGRect(x: 100, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width - 40, height: 30))
            label.text = "No products available"
            label.textColor = .black
            allProductsView.addSubview(label)
        } else {
            // Add a label for each product
            var yOffset: CGFloat = 50.0 // starting y offset
            for product in products {
                let idLabel = UILabel(frame: CGRect(x: 20, y: yOffset, width: UIScreen.main.bounds.width - 40, height: 30))
                idLabel.text = "ID: \(product.id)"
                idLabel.textColor = .black
                allProductsView.addSubview(idLabel)
                
                let nameLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 30.0, width: UIScreen.main.bounds.width - 40, height: 30))
                nameLabel.text = "Name: \(product.name)"
                nameLabel.textColor = .black
                allProductsView.addSubview(nameLabel)
                
                let productDescriptionLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 60.0, width: UIScreen.main.bounds.width - 40, height: 30))
                productDescriptionLabel.text = "Price: \(product.product_description)"
                productDescriptionLabel.textColor = .black
                allProductsView.addSubview(productDescriptionLabel)
                
                let productRatingLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 90.0, width: UIScreen.main.bounds.width - 40, height: 30))
                productRatingLabel.text = "Price: \(product.product_rating)"
                productRatingLabel.textColor = .black
                allProductsView.addSubview(productRatingLabel)
                
                let companyIdLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 120.0, width: UIScreen.main.bounds.width - 40, height: 30))
                companyIdLabel.text = "Company: \(product.company_id)"
                companyIdLabel.textColor = .black
                allProductsView.addSubview(companyIdLabel)
                
                let quantityLabel = UILabel(frame: CGRect(x: 20, y: yOffset + 150.0, width: UIScreen.main.bounds.width - 40, height: 30))
                quantityLabel.text = "Price: \(product.quantity)"
                quantityLabel.textColor = .black
                allProductsView.addSubview(quantityLabel)
                
                // Create a background color with rounded edges for each label
                let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
                let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 180))
                labelBackgroundView.backgroundColor = backgroundColor
                labelBackgroundView.layer.cornerRadius = 10
                allProductsView.insertSubview(labelBackgroundView, belowSubview: idLabel)
                
                yOffset += 200.0 // increment y offset for next label
            }
        }
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allProductsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(allProductsView)
    }
    
    // All Product Post Declarations
    @objc func managePostsButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Manage Product Posts"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new product post
        let addButton = UIButton(type: .system)
        addButton.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        addButton.setTitle("Add New Post", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.layer.cornerRadius = 10
        addButton.layer.borderWidth = 1
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.addTarget(self, action: #selector(addProductPostTapped), for: .touchUpInside)
        optionsView.addSubview(addButton)
        
        // Add a button to update an existing product post
        let updateButton = UIButton(type: .system)
        updateButton.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        updateButton.setTitle("Update Post", for: .normal)
        updateButton.setTitleColor(.white, for: .normal)
        updateButton.backgroundColor = .systemGreen
        updateButton.layer.cornerRadius = 10
        updateButton.layer.borderWidth = 1
        updateButton.layer.borderColor = UIColor.black.cgColor
        updateButton.addTarget(self, action: #selector(updateProductPostTapped), for: .touchUpInside)
        optionsView.addSubview(updateButton)
        
        // Add a button to delete an existing product post
        let deleteButton = UIButton(type: .system)
        deleteButton.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
        deleteButton.setTitle("Delete Post", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .systemRed
        deleteButton.layer.cornerRadius = 10
        deleteButton.layer.borderWidth = 1
        deleteButton.layer.borderColor = UIColor.black.cgColor
        deleteButton.addTarget(self, action: #selector(DeleteProductPostTapped), for: .touchUpInside)
        optionsView.addSubview(deleteButton)
        
        // Add a button to view all product posts
        let viewAllButton = UIButton(type: .system)
        viewAllButton.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        viewAllButton.setTitle("View All Posts", for: .normal)
        viewAllButton.setTitleColor(.white, for: .normal)
        viewAllButton.backgroundColor = .systemOrange
        viewAllButton.layer.cornerRadius = 10
        viewAllButton.layer.borderWidth = 1
        viewAllButton.layer.borderColor = UIColor.black.cgColor
        viewAllButton.addTarget(self, action: #selector(ViewAllProductPostsTapped), for: .touchUpInside)
        optionsView.addSubview(viewAllButton)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    
    @objc func addProductPostTapped() {
        // create new view
        let productPostView = UIView(frame: UIScreen.main.bounds)
        productPostView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        productPostView.addSubview(idLabel)
        
        ProductPostIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostIdField.borderStyle = .roundedRect
        ProductPostIdField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostIdField)
        
        // add subviews for each input field
        let ProductPostProductTypeIdLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        ProductPostProductTypeIdLabel.text = "Product Type ID:"
        productPostView.addSubview(ProductPostProductTypeIdLabel)
        
        ProductPostProductTypeIdField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostProductTypeIdField.borderStyle = .roundedRect
        ProductPostProductTypeIdField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostProductTypeIdField)
        
        // add subviews for each input field
        let ProductPostCompanyIdLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        ProductPostCompanyIdLabel.text = "Company ID:"
        productPostView.addSubview(ProductPostCompanyIdLabel)
        
        ProductPostCompanyIdField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostCompanyIdField.borderStyle = .roundedRect
        ProductPostCompanyIdField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostCompanyIdField)
        
        // add subviews for each input field
        let ProductPostProductIdLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        ProductPostProductIdLabel.text = "Product ID:"
        productPostView.addSubview(ProductPostProductIdLabel)
        
        ProductPostProductIdField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostProductIdField.borderStyle = .roundedRect
        ProductPostProductIdField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostProductIdField)
        
        // add subviews for each input field
        let ProductPostPostedDateLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 30))
        ProductPostPostedDateLabel.text = "Posted Date:"
        productPostView.addSubview(ProductPostPostedDateLabel)
        
        ProductPostPostedDateField = UITextField(frame: CGRect(x: 120, y: 300, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostPostedDateField.borderStyle = .roundedRect
        ProductPostPostedDateField.placeholder = "yyyy-mm-dd"
        ProductPostPostedDateField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostPostedDateField)
        
        // add subviews for each input field
        let ProductPostPriceLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 100, height: 30))
        ProductPostPriceLabel.text = "Price:"
        productPostView.addSubview(ProductPostPriceLabel)
        
        ProductPostPriceField = UITextField(frame: CGRect(x: 120, y: 350, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostPriceField.borderStyle = .roundedRect
        ProductPostPriceField.keyboardType = .numberPad  // only accept numeric input
        productPostView.addSubview(ProductPostPriceField)
        
        // add subviews for each input field
        let ProductPostDescriptionLabel = UILabel(frame: CGRect(x: 20, y: 400, width: 100, height: 30))
        ProductPostDescriptionLabel.text = "Description:"
        productPostView.addSubview(ProductPostDescriptionLabel)
        
        ProductPostDescriptionField = UITextField(frame: CGRect(x: 120, y: 400, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostDescriptionField.borderStyle = .roundedRect
        productPostView.addSubview(ProductPostDescriptionField)
        
        // add submit button
        let addProductPost = UIButton(type: .system)
        addProductPost.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        addProductPost.setTitle("Add Product Post", for: .normal)
        addProductPost.setTitleColor(.black, for: .normal)
        addProductPost.addTarget(self, action: #selector(AddProductPost), for: .touchUpInside)
        addProductPost.backgroundColor = UIColor.green
        addProductPost.layer.cornerRadius = 5
        addProductPost.layer.borderWidth = 1
        addProductPost.layer.borderColor = UIColor.black.cgColor
        productPostView.addSubview(addProductPost)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 500, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productPostView.addSubview(backButton)
        
        // add the product post view to the window
        window?.addSubview(productPostView)
    }
    
    @objc func AddProductPost() {
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
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Check if the product type ID is valid
            if !productManager.productTypes.contains(where: { $0.id == productTypeId }) {
                let alert = UIAlertController(title: "Error", message: "Product type ID \(productTypeId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Check if the company ID is valid
            if !productManager.companies.contains(where: { $0.id == companyId }) {
                let alert = UIAlertController(title: "Error", message: "Company ID \(companyId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Check if the product ID is valid
            if !productManager.products.contains(where: { $0.id == ProductId }) {
                let alert = UIAlertController(title: "Error", message: "Product ID \(ProductId) is invalid.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
            guard let date = dateFormatter.date(from: productDateText) else {
                let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            // Create a new product post and add it to the productPosts array
            let newProductPost = Product_Post(product_post_id: postId, product_type_id: productTypeId, company_id: companyId, product_id: ProductId, posted_date: date, price: ProductPrice, description: productDescription)
            productManager.addProductPost(productPost: newProductPost)
            
            let alert = UIAlertController(title: "Product Post Added Successfully", message: "Press OK to continue", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func ViewAllProductPostsTapped() {
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
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        allProductPostsView.addSubview(backButton)
        // add the product post view to the window
        window?.addSubview(allProductPostsView)
    }
    
    @objc func updateProductPostTapped() {
        // create new view
        let productPostUpdateView = UIView(frame: UIScreen.main.bounds)
        productPostUpdateView.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        productPostUpdateView.addSubview(idLabel)
        
        ProductPostIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostIdField.borderStyle = .roundedRect
        ProductPostIdField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostIdField)
        
        // add subviews for each input field
        let ProductPostProductTypeIdLabel = UILabel(frame: CGRect(x: 20, y: 150, width: 100, height: 30))
        ProductPostProductTypeIdLabel.text = "Product Type ID:"
        productPostUpdateView.addSubview(ProductPostProductTypeIdLabel)
        
        ProductPostProductTypeIdField = UITextField(frame: CGRect(x: 120, y: 150, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostProductTypeIdField.borderStyle = .roundedRect
        ProductPostProductTypeIdField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostProductTypeIdField)
        
        // add subviews for each input field
        let ProductPostCompanyIdLabel = UILabel(frame: CGRect(x: 20, y: 200, width: 100, height: 30))
        ProductPostCompanyIdLabel.text = "Company ID:"
        productPostUpdateView.addSubview(ProductPostCompanyIdLabel)
        
        ProductPostCompanyIdField = UITextField(frame: CGRect(x: 120, y: 200, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostCompanyIdField.borderStyle = .roundedRect
        ProductPostCompanyIdField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostCompanyIdField)
        
        // add subviews for each input field
        let ProductPostProductIdLabel = UILabel(frame: CGRect(x: 20, y: 250, width: 100, height: 30))
        ProductPostProductIdLabel.text = "Product ID:"
        productPostUpdateView.addSubview(ProductPostProductIdLabel)
        
        ProductPostProductIdField = UITextField(frame: CGRect(x: 120, y: 250, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostProductIdField.borderStyle = .roundedRect
        ProductPostProductIdField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostProductIdField)
        
        // add subviews for each input field
        let ProductPostPostedDateLabel = UILabel(frame: CGRect(x: 20, y: 300, width: 100, height: 30))
        ProductPostPostedDateLabel.text = "Posted Date:"
        productPostUpdateView.addSubview(ProductPostPostedDateLabel)
        
        ProductPostPostedDateField = UITextField(frame: CGRect(x: 120, y: 300, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostPostedDateField.borderStyle = .roundedRect
        ProductPostPostedDateField.placeholder = "yyyy-mm-dd"
        ProductPostPostedDateField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostPostedDateField)
        
        // add subviews for each input field
        let ProductPostPriceLabel = UILabel(frame: CGRect(x: 20, y: 350, width: 100, height: 30))
        ProductPostPriceLabel.text = "Price:"
        productPostUpdateView.addSubview(ProductPostPriceLabel)
        
        ProductPostPriceField = UITextField(frame: CGRect(x: 120, y: 350, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostPriceField.borderStyle = .roundedRect
        ProductPostPriceField.keyboardType = .numberPad  // only accept numeric input
        productPostUpdateView.addSubview(ProductPostPriceField)
        
        // add subviews for each input field
        let ProductPostDescriptionLabel = UILabel(frame: CGRect(x: 20, y: 400, width: 100, height: 30))
        ProductPostDescriptionLabel.text = "Description:"
        productPostUpdateView.addSubview(ProductPostDescriptionLabel)
        
        ProductPostDescriptionField = UITextField(frame: CGRect(x: 120, y: 400, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostDescriptionField.borderStyle = .roundedRect
        productPostUpdateView.addSubview(ProductPostDescriptionField)
        
        // add submit button
        let addProductPost = UIButton(type: .system)
        addProductPost.frame = CGRect(x: 20, y: 450, width: UIScreen.main.bounds.width - 40, height: 30)
        addProductPost.setTitle("Update Product Post", for: .normal)
        addProductPost.setTitleColor(.black, for: .normal)
        addProductPost.addTarget(self, action: #selector(updateProductPost), for: .touchUpInside)
        addProductPost.backgroundColor = UIColor.green
        addProductPost.layer.cornerRadius = 5
        addProductPost.layer.borderWidth = 1
        addProductPost.layer.borderColor = UIColor.black.cgColor
        productPostUpdateView.addSubview(addProductPost)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 500, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productPostUpdateView.addSubview(backButton)
        
        // add the product post view to the window
        window?.addSubview(productPostUpdateView)
    }
    
    @objc func updateProductPost() {
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
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                // Check if the company ID is valid
                if !productManager.companies.contains(where: { $0.id == companyId }) {
                    let alert = UIAlertController(title: "Error", message: "Company ID \(companyId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                // Check if the product ID is valid
                if !productManager.products.contains(where: { $0.id == ProductId }) {
                    let alert = UIAlertController(title: "Error", message: "Product ID \(ProductId) is invalid.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
                guard let date = dateFormatter.date(from: productDateText) else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                    return
                }
                // Create a new product post and add it to the productPosts array
                let newProductPost = Product_Post(product_post_id: postId, product_type_id: productTypeId, company_id: companyId, product_id: ProductId, posted_date: date, price: ProductPrice, description: productDescription)
                productManager.updateProductPost(productPost: newProductPost)
                
                let alert = UIAlertController(title: "Product Post updated Successfully", message: "Press OK to continue", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
                return
            }
            else{
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to update.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            // Handle case where any required field is empty or not a valid integer
            let alert = UIAlertController(title: "Error", message: "One or more fields are empty or contain invalid values.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func DeleteProductPostTapped() {
        // create new view
        let DeletePost = UIView(frame: UIScreen.main.bounds)
        DeletePost.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        DeletePost.addSubview(idLabel)
        
        ProductPostIdField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostIdField.borderStyle = .roundedRect
        ProductPostIdField.keyboardType = .numberPad  // only accept numeric input
        DeletePost.addSubview(ProductPostIdField)
        
        // add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Delete Product", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(DeleteProductPost), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        DeletePost.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        DeletePost.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(DeletePost)
    }
    
    @objc func DeleteProductPost(){
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
                    if let rootViewController = window?.rootViewController {
                        rootViewController.present(alert, animated: true, completion: nil)
                    }
                }
            } else {
                // Handle case where product post id is not valid
                let alert = UIAlertController(title: "Error", message: "Product Post ID does not exist to delete.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let rootViewController = window?.rootViewController {
                    rootViewController.present(alert, animated: true, completion: nil)
                }
            }
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }

    //  Search Declarations
    @objc func searchButtonTapped() {
        // Create a new view to display the options
        let optionsView = UIView(frame: UIScreen.main.bounds)
        optionsView.backgroundColor = .darkGray
        
        // Add a label to display the title
        let titleLabel = UILabel(frame: CGRect(x: 80, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        titleLabel.text = "Select Search Type"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        optionsView.addSubview(titleLabel)
        
        // Add a button to add a new product post
        let ProductSearch = UIButton(type: .system)
        ProductSearch.frame = CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 50)
        ProductSearch.setTitle("Product Search", for: .normal)
        ProductSearch.setTitleColor(.white, for: .normal)
        ProductSearch.backgroundColor = .systemBlue
        ProductSearch.layer.cornerRadius = 10
        ProductSearch.layer.borderWidth = 1
        ProductSearch.layer.borderColor = UIColor.black.cgColor
        ProductSearch.addTarget(self, action: #selector(ProductSearchTapped), for: .touchUpInside)
        optionsView.addSubview(ProductSearch)
        
        // Add a button to update an existing product post
        let ProductTypeSearch = UIButton(type: .system)
        ProductTypeSearch.frame = CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 50)
        ProductTypeSearch.setTitle("Product Type search", for: .normal)
        ProductTypeSearch.setTitleColor(.white, for: .normal)
        ProductTypeSearch.backgroundColor = .systemGreen
        ProductTypeSearch.layer.cornerRadius = 10
        ProductTypeSearch.layer.borderWidth = 1
        ProductTypeSearch.layer.borderColor = UIColor.black.cgColor
        ProductTypeSearch.addTarget(self, action: #selector(ProductTypeSearchTapped), for: .touchUpInside)
        optionsView.addSubview(ProductTypeSearch)
        
        // Add a button to delete an existing product post
        let ProductPostSearch = UIButton(type: .system)
        ProductPostSearch.frame = CGRect(x: 20, y: 240, width: UIScreen.main.bounds.width - 40, height: 50)
        ProductPostSearch.setTitle("Product Post Search", for: .normal)
        ProductPostSearch.setTitleColor(.white, for: .normal)
        ProductPostSearch.backgroundColor = .systemRed
        ProductPostSearch.layer.cornerRadius = 10
        ProductPostSearch.layer.borderWidth = 1
        ProductPostSearch.layer.borderColor = UIColor.black.cgColor
        ProductPostSearch.addTarget(self, action: #selector(ProductPostSearchTapped), for: .touchUpInside)
        optionsView.addSubview(ProductPostSearch)
        
        // Add a button to view all product posts
        let CompanySearch = UIButton(type: .system)
        CompanySearch.frame = CGRect(x: 20, y: 310, width: UIScreen.main.bounds.width - 40, height: 50)
        CompanySearch.setTitle("Company Search", for: .normal)
        CompanySearch.setTitleColor(.white, for: .normal)
        CompanySearch.backgroundColor = .systemOrange
        CompanySearch.layer.cornerRadius = 10
        CompanySearch.layer.borderWidth = 1
        CompanySearch.layer.borderColor = UIColor.black.cgColor
        CompanySearch.addTarget(self, action: #selector(companySearch), for: .touchUpInside)
        optionsView.addSubview(CompanySearch)
        
        // Add a button to view all product posts
        let RatingSearch = UIButton(type: .system)
        RatingSearch.frame = CGRect(x: 20, y: 380, width: UIScreen.main.bounds.width - 40, height: 50)
        RatingSearch.setTitle("Rating Search", for: .normal)
        RatingSearch.setTitleColor(.white, for: .normal)
        RatingSearch.backgroundColor = .systemTeal
        RatingSearch.layer.cornerRadius = 10
        RatingSearch.layer.borderWidth = 1
        RatingSearch.layer.borderColor = UIColor.black.cgColor
        RatingSearch.addTarget(self, action: #selector(ratingSearch), for: .touchUpInside)
        optionsView.addSubview(RatingSearch)
        
        // Add a "Go Back" button to the view
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        optionsView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(optionsView)
    }
    
    @objc func ProductSearchTapped() {
        // create new view
        let ProductSearch = UIView(frame: UIScreen.main.bounds)
        ProductSearch.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        ProductSearch.addSubview(idLabel)
        
        ProductSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductSearchField.borderStyle = .roundedRect
        ProductSearchField.keyboardType = .numberPad  // only accept numeric input
        ProductSearch.addSubview(ProductSearchField)
        
        //         add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Product", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitProductSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        ProductSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        ProductSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(ProductSearch)
    }
    
    @objc func ProductTypeSearchTapped() {
        // create new view
        let ProductTypeSearch = UIView(frame: UIScreen.main.bounds)
        ProductTypeSearch.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        ProductTypeSearch.addSubview(idLabel)
        
        ProductTypeSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductTypeSearchField.borderStyle = .roundedRect
        ProductTypeSearchField.keyboardType = .numberPad  // only accept numeric input
        ProductTypeSearch.addSubview(ProductTypeSearchField)
        
        //  add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Product Type", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitProductTypeSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        ProductTypeSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        ProductTypeSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(ProductTypeSearch)
    }
    
    @objc func ProductPostSearchTapped() {
        // create new view
        let ProductPostSearch = UIView(frame: UIScreen.main.bounds)
        ProductPostSearch.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        ProductPostSearch.addSubview(idLabel)
        
        ProductPostSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ProductPostSearchField.borderStyle = .roundedRect
        ProductPostSearchField.keyboardType = .numberPad  // only accept numeric input
        ProductPostSearch.addSubview(ProductPostSearchField)
        
        //  add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Product Post", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitProductPostSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        ProductPostSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        ProductPostSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(ProductPostSearch)
    }
    
    @objc func companySearch() {
        // create new view
        let companySearch = UIView(frame: UIScreen.main.bounds)
        companySearch.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "ID:"
        companySearch.addSubview(idLabel)
        
        companySearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        companySearchField.borderStyle = .roundedRect
        companySearchField.keyboardType = .numberPad  // only accept numeric input
        companySearch.addSubview(companySearchField)
        
        //         add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Search Company", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitCompanySearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        companySearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        companySearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(companySearch)
    }
    
    @objc func ratingSearch() {
        // create new view
        let ratingSearch = UIView(frame: UIScreen.main.bounds)
        ratingSearch.backgroundColor = .white
        
        // add subviews for each input field
        let idLabel = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 30))
        idLabel.text = "Enter Rating:"
        ratingSearch.addSubview(idLabel)
        
        ratingSearchField = UITextField(frame: CGRect(x: 120, y: 100, width: UIScreen.main.bounds.width - 140, height: 30))
        ratingSearchField.borderStyle = .roundedRect
        ratingSearchField.keyboardType = .numberPad  // only accept numeric input
        ratingSearch.addSubview(ratingSearchField)
        
        //         add submit button
        let submitButton = UIButton(type: .system)
        submitButton.frame = CGRect(x: 20, y: 150, width: UIScreen.main.bounds.width - 40, height: 30)
        submitButton.setTitle("Rating Search", for: .normal)
        submitButton.setTitleColor(.black, for: .normal)
        submitButton.addTarget(self, action: #selector(submitRatingSearch), for: .touchUpInside)
        submitButton.backgroundColor = UIColor.green
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        ratingSearch.addSubview(submitButton)
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        ratingSearch.addSubview(backButton)
        
        // add the product view to the window
        window?.addSubview(ratingSearch)
    }
    
    @objc func submitProductSearch() {
        print("submitProductSearch button pressed")
        guard let idText = ProductSearchField?.text, let productId = Int(idText) else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Product ID Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let products = productManager.products.filter { $0.id == productId }
        guard let product = products.first else {
            // handle case where product with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Product not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the product
        let productView = UIView(frame: UIScreen.main.bounds)
        productView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the product
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "ID: \(product.id)"
        idLabel.textColor = .black
        productView.addSubview(idLabel)
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        nameLabel.text = "Name: \(product.name)"
        nameLabel.textColor = .black
        productView.addSubview(nameLabel)
        
        let productDescriptionLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        productDescriptionLabel.text = "Description: \(product.product_description)"
        productDescriptionLabel.textColor = .black
        productView.addSubview(productDescriptionLabel)
        
        let productRatingLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        productRatingLabel.text = "Rating: \(product.product_rating)"
        productRatingLabel.textColor = .black
        productView.addSubview(productRatingLabel)
        
        let companyIdLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 30))
        companyIdLabel.text = "Company: \(product.company_id)"
        companyIdLabel.textColor = .black
        productView.addSubview(companyIdLabel)
        
        let quantityLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        quantityLabel.text = "Quantity: \(product.quantity)"
        quantityLabel.textColor = .black
        productView.addSubview(quantityLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        productView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220.0 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productView.addSubview(backButton)
        // Add the view to the window
        window?.addSubview(productView)
    }
    
    @objc func submitProductTypeSearch() {
        print("submitProductTypeSearch button pressed")
        guard let idText = ProductTypeSearchField?.text, let ProductTypeSearch = Int(idText) else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Product Type ID Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let productTypes = productManager.productTypes.filter { $0.id == ProductTypeSearch }
        guard let ProductType = productTypes.first else {
            // handle case where product with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Product Type with this ID not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the product
        let productTypeView = UIView(frame: UIScreen.main.bounds)
        productTypeView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the product
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "ID: \(ProductType.id)"
        idLabel.textColor = .black
        productTypeView.addSubview(idLabel)
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        nameLabel.text = "Product Type: \(ProductType.product_type)"
        nameLabel.textColor = .black
        productTypeView.addSubview(nameLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 100))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        productTypeView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 100.0 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productTypeView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(productTypeView)
    }
    
    @objc func submitProductPostSearch() {
        print("submitProductPostSearch button pressed")
        guard let idText = ProductPostSearchField?.text, let productPostId = Int(idText) else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Product Post ID Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let productPosts = productManager.productPosts.filter { $0.product_post_id == productPostId }
        guard let productPost = productPosts.first else {
            // handle case where product with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Product Post with this ID not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the product
        let productPostView = UIView(frame: UIScreen.main.bounds)
        productPostView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the product
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Product Post ID: \(productPost.product_post_id)"
        idLabel.textColor = .black
        productPostView.addSubview(idLabel)
        
        let ProductPostTypeLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        ProductPostTypeLabel.text = "Product Type ID: \(productPost.product_type_id)"
        ProductPostTypeLabel.textColor = .black
        productPostView.addSubview(ProductPostTypeLabel)
        
        let companyIdLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        companyIdLabel.text = "Company ID: \(productPost.company_id)"
        companyIdLabel.textColor = .black
        productPostView.addSubview(companyIdLabel)
        
        let productIdLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        productIdLabel.text = "Product ID: \(productPost.product_id)"
        productIdLabel.textColor = .black
        productPostView.addSubview(productIdLabel)
        
        let postedDateLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 30))
        postedDateLabel.text = "Posted Date: \(productPost.posted_date)"
        postedDateLabel.textColor = .black
        productPostView.addSubview(postedDateLabel)
        
        let priceLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        priceLabel.text = "Price: \(productPost.price)"
        priceLabel.textColor = .black
        productPostView.addSubview(priceLabel)
        
        let productPostDescriptionLabel = UILabel(frame: CGRect(x: 20, y: 230, width: UIScreen.main.bounds.width - 40, height: 30))
        productPostDescriptionLabel.text = "Description: \(productPost.description)"
        productPostDescriptionLabel.textColor = .black
        productPostView.addSubview(productPostDescriptionLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 250))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        productPostView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 250.0 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productPostView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(productPostView)
    }
    
    @objc func submitCompanySearch() {
        print("submitCompanySearch button pressed")
        guard let idText = companySearchField?.text, let companyId = Int(idText) else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Company ID Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let Companies = productManager.companies.filter { $0.id == companyId }
        guard let company = Companies.first else {
            // handle case where product with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Company with this ID not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the product
        let companyView = UIView(frame: UIScreen.main.bounds)
        companyView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the product
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "Company ID: \(company.id)"
        idLabel.textColor = .black
        companyView.addSubview(idLabel)
        
        let CompanyNameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        CompanyNameLabel.text = "Company Name: \(company.name)"
        CompanyNameLabel.textColor = .black
        companyView.addSubview(CompanyNameLabel)
        
        let addressLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        addressLabel.text = "Company Address: \(company.address)"
        addressLabel.textColor = .black
        companyView.addSubview(addressLabel)
        
        let countryLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        countryLabel.text = "Company Country: \(company.country)"
        countryLabel.textColor = .black
        companyView.addSubview(countryLabel)
        
        let zipLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 30))
        zipLabel.text = "Company Zip: \(company.zip)"
        zipLabel.textColor = .black
        companyView.addSubview(zipLabel)
        
        let CompanyTypeLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        CompanyTypeLabel.text = "Company Type: \(company.company_type)"
        CompanyTypeLabel.textColor = .black
        companyView.addSubview(CompanyTypeLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        companyView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        companyView.addSubview(backButton)
        
        window?.addSubview(companyView)
    }
    
    @objc func submitRatingSearch() {
        print("submitRatingSearch button pressed")
        guard let idText = ratingSearchField?.text, let productRating = Double(idText) else {
            // handle case where idField has no text or the text is not a valid integer
            let alert = UIAlertController(title: "Error", message: "Empty Rating Field", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        let productRatings = productManager.products.filter { $0.product_rating == productRating }
        guard let product = productRatings.first else {
            // handle case where product with entered ID is not found
            let alert = UIAlertController(title: "Error", message: "Product with this rating found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            if let rootViewController = window?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
            return
        }
        
        // Create a new view to display the product
        let productView = UIView(frame: UIScreen.main.bounds)
        productView.backgroundColor = .systemTeal
        
        var yOffset: CGFloat = 50.0 // starting y offset
        // Add labels for the product
        let idLabel = UILabel(frame: CGRect(x: 20, y: 50, width: UIScreen.main.bounds.width - 40, height: 30))
        idLabel.text = "ID: \(product.id)"
        idLabel.textColor = .black
        productView.addSubview(idLabel)
        
        let nameLabel = UILabel(frame: CGRect(x: 20, y: 80, width: UIScreen.main.bounds.width - 40, height: 30))
        nameLabel.text = "Name: \(product.name)"
        nameLabel.textColor = .black
        productView.addSubview(nameLabel)
        
        let productDescriptionLabel = UILabel(frame: CGRect(x: 20, y: 110, width: UIScreen.main.bounds.width - 40, height: 30))
        productDescriptionLabel.text = "Description: \(product.product_description)"
        productDescriptionLabel.textColor = .black
        productView.addSubview(productDescriptionLabel)
        
        let productRatingLabel = UILabel(frame: CGRect(x: 20, y: 140, width: UIScreen.main.bounds.width - 40, height: 30))
        productRatingLabel.text = "Rating: \(product.product_rating)"
        productRatingLabel.textColor = .black
        productView.addSubview(productRatingLabel)
        
        let companyIdLabel = UILabel(frame: CGRect(x: 20, y: 170, width: UIScreen.main.bounds.width - 40, height: 30))
        companyIdLabel.text = "Company: \(product.company_id)"
        companyIdLabel.textColor = .black
        productView.addSubview(companyIdLabel)
        
        let quantityLabel = UILabel(frame: CGRect(x: 20, y: 200, width: UIScreen.main.bounds.width - 40, height: 30))
        quantityLabel.text = "Quantity: \(product.quantity)"
        quantityLabel.textColor = .black
        productView.addSubview(quantityLabel)
        
        // Create a background color with rounded edges for each label
        let backgroundColor = UIColor(red: CGFloat.random(in: 0.5...1.0), green: CGFloat.random(in: 0.5...1.0), blue: CGFloat.random(in: 0.5...1.0), alpha: 1.0)
        let labelBackgroundView = UIView(frame: CGRect(x: 0, y: yOffset, width: UIScreen.main.bounds.width, height: 220))
        labelBackgroundView.backgroundColor = backgroundColor
        labelBackgroundView.layer.cornerRadius = 10
        productView.insertSubview(labelBackgroundView, belowSubview: idLabel)
        
        yOffset += 220.0 // increment y offset for next label
        
        // add the go back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 80, width: UIScreen.main.bounds.width - 40, height: 30)
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.backgroundColor = UIColor.systemPink
        backButton.layer.cornerRadius = 5
        backButton.layer.borderWidth = 1
        backButton.layer.borderColor = UIColor.black.cgColor
        productView.addSubview(backButton)
        
        // Add the view to the window
        window?.addSubview(productView)
    }
    
    // Go back Functions
    @objc func goBack() {
        // remove the product view or product type view from the window
        if let backButton = window?.subviews.last {
            backButton.removeFromSuperview()
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
    
