//
//  SearchViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit
import CoreData

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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %d", id)
           
           do {
               let productTypes = try context.fetch(fetchRequest)
               if let productType = productTypes.first {
                   let productTypeString = "ID: \(productType.id)\nProduct Type: \(productType.product_type ?? "")\n"
                   textView.text = productTypeString
               } else {
                   textView.text = "Product type with ID \(id) not found"
               }
           } catch {
               textView.text = "Error retrieving product type with ID \(id): \(error.localizedDescription)"
           }
       }
    
    
    func displayCompanyDetails(id: Int, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<CompanyData> = CompanyData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            do {
                let results = try context.fetch(fetchRequest)
                if let company = results.first {
                    let companyString = "ID: \(String(company.id))\nname: \(company.name ?? "")\naddress: \(company.address ?? "")\ncountry: \(company.country ?? "")\nzip: \(String(company.zip ))\ncompany_type: \(company.company_type ?? "")"
                    textView.text = companyString
                } else {
                    textView.text = "Company with ID \(id) not found"
                }
            } catch {
                // handle error
                print("Error fetching company: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to fetch company details.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    func displayProductDetails(id: Int, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %d", id)
           do {
               let results = try context.fetch(fetchRequest)
               if let product = results.first {
                   let productString = "ID: \(product.id)\nname: \(product.name ?? "")\nproduct_description: \(product.product_description ?? "")\nproduct_rating: \(product.product_rating)\ncompany_id: \(product.company_id)\nquantity: \(product.quantity)"
                   textView.text = productString
               } else {
                   textView.text = "Product with ID \(id) not found"
               }
           } catch {
               // handle error
               print("Error fetching product: \(error)")
               let alert = UIAlertController(title: "Error", message: "Unable to fetch product details.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
    }
    
    func displayProductPostDetails(id: Int, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %d", id)
            do {
                let results = try context.fetch(fetchRequest)
                if let productPost = results.first {
                    let productPostString = "ID: \(productPost.id)\nproduct_type_id: \(productPost.product_type_id)\ncompany_id: \(productPost.company_id )\nproduct_id: \(productPost.product_id)\nposted_date: \(productPost.posted_date ?? Date())\nprice: \(productPost.price)\ndescription: \(productPost.description_ ?? "" )"
                    textView.text = productPostString
                } else {
                    textView.text = "Product post with ID \(id) not found"
                }
            } catch {
                // handle error
                print("Error fetching product post: \(error)")
                let alert = UIAlertController(title: "Error", message: "Unable to fetch product post details.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    
    func displayRatingsDetails(rating: Double, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
           let ratingTolerance = 0.01 // the range of tolerance around the target rating
           fetchRequest.predicate = NSPredicate(format: "product_rating >= %f AND product_rating <= %f", rating - ratingTolerance, rating + ratingTolerance)
           do {
               let results = try context.fetch(fetchRequest)
               if let product = results.first {
                   let productString = "ID: \(product.id)\nname: \(product.name ?? "")\nproduct_description: \(product.product_description ?? "")\nproduct_rating: \(product.product_rating)\ncompany_id: \(product.company_id)\nquantity: \(product.quantity)"
                   textView.text = productString
               } else {
                   textView.text = "Product type with rating \(rating) not found"
               }
           } catch {
               // handle error
               print("Error fetching products: \(error)")
               let alert = UIAlertController(title: "Error", message: "Unable to fetch product details.", preferredStyle: .alert)
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
