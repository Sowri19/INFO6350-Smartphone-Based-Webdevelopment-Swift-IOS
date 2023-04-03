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
            guard let idText = SearchidField.text, !idText.isEmpty else {
                // show alert for empty field
                let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            guard let id = Int(idText) else {
                // show alert for invalid input
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer ID.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let vc = SearchViewController(nibName: "DisplaySearchedCompanyView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayCompanyDetails(id: id, textView: textView)
            }
    }

    @IBAction func searchProduct(_ sender: UIButton) {
        print("submitProductSearch button pressed")
            guard let idString = SearchidField.text, !idString.isEmpty else {
                // Alert the user that the ID field is empty
                let alert = UIAlertController(title: "Missing Information", message: "Please enter a product ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            guard let id = Int(idString) else {
                // Alert the user that the ID field contains invalid input
                let alert = UIAlertController(title: "Error", message: "Please enter a valid product ID", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            let vc = SearchViewController(nibName: "DisplaySearchedProductView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
            if let textView = vc.textView {
                displayProductDetails(id: id, textView: textView)
            }
    }

    @IBAction func searchProductPost(_ sender: UIButton) {
        print("submitProductPostSearch button pressed")
           guard let idText = SearchidField.text, !idText.isEmpty else {
               // show alert for empty field
               let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           guard let id = Int(idText) else {
               // show alert for invalid data type
               let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer for ID.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           let vc = SearchViewController(nibName: "DisplaySearchedProductPostView", bundle: nil)
           self.present(vc, animated: true, completion: nil)
           if let textView = vc.textView {
               displayProductPostDetails(id: id, textView: textView)
           }
    }

    @IBAction func searchRatings(_ sender: UIButton) {
        print("submitRatingSearch button pressed")
           guard let ratingText = RatingsField.text, !ratingText.isEmpty else {
               // show alert for empty field
               let alert = UIAlertController(title: "Missing Information", message: "Please enter a rating.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           guard let rating = Double(ratingText) else {
               // show alert for invalid input
               let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid rating.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
               return
           }
           
           let vc = SearchViewController(nibName: "DisplaySearchedRatingsView", bundle: nil)
           self.present(vc, animated: true, completion: nil)
           
           if let textView = vc.textView {
               displayRatingsDetails(rating: rating, textView: textView)
           }
    }

    @IBAction func searchProductType(_ sender: UIButton) {
    print("submitProductTypeSearch button pressed")
       guard let idText = SearchidField.text, !idText.isEmpty else {
           // show alert for empty field
           let alert = UIAlertController(title: "Missing Information", message: "Please enter an ID.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
           return
       }
       guard let id = Int(idText) else {
           // show alert for invalid input
           let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid integer for ID.", preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
           return
       }
       let vc = SearchViewController(nibName: "DisplaySearchedProductTypeView", bundle: nil)
       self.present(vc, animated: true, completion: nil)
       if let textView = vc.textView {
           displayProductTypeDetails(id: id, textView: textView)
       }
    }
    
    func displayProductTypeDetails(id: Int, textView: UITextView) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
           let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "id == %d", id)
           do {
               let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
               fetchRequest.predicate = NSPredicate(format: "product_type_id == %d", id)
               let results = try context.fetch(fetchRequest)
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               var postString = ""
               for post in results {
                   postString += "Post ID: \(post.id)\n"
                   postString += "Product Type ID: \(post.product_type_id)\n"
                      postString += "Company ID: \(post.company_id)\n"
                      postString += "Product ID: \(post.product_id)\n"
                       if let postedDate = post.posted_date {
                              postString += "Posted Date: \(dateFormatter.string(from: postedDate))\n"
                          }
                      postString += "Price: \(post.price)\n"
                   if let description = post.description_ {
                           postString += "Description: \(description)\n\n"
                       } else {
                           postString += "Description: N/A\n\n"
                       }
                  }
               if postString.isEmpty {
                           textView.text = "No product posts found for product type ID \(id)"
                       } else {
                           textView.text = postString
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
                let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "company_id == %d", id)
                let results = try context.fetch(fetchRequest)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                var postString = ""
                for post in results {
                    postString += "Post ID: \(post.id)\n"
                    postString += "Product Type ID: \(post.product_type_id)\n"
                       postString += "Company ID: \(post.company_id)\n"
                       postString += "Product ID: \(post.product_id)\n"
                        if let postedDate = post.posted_date {
                               postString += "Posted Date: \(dateFormatter.string(from: postedDate))\n"
                           }
                       postString += "Price: \(post.price)\n"
                    if let description = post.description_ {
                            postString += "Description: \(description)\n\n"
                        } else {
                            postString += "Description: N/A\n\n"
                        }
                   }
                if postString.isEmpty {
                            textView.text = "No product posts found for product type ID \(id)"
                        } else {
                            textView.text = postString
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
               let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
               fetchRequest.predicate = NSPredicate(format: "product_id == %d", id)
               let results = try context.fetch(fetchRequest)
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               var postString = ""
               for post in results {
                   postString += "Post ID: \(post.id)\n"
                   postString += "Product Type ID: \(post.product_type_id)\n"
                      postString += "Company ID: \(post.company_id)\n"
                      postString += "Product ID: \(post.product_id)\n"
                       if let postedDate = post.posted_date {
                              postString += "Posted Date: \(dateFormatter.string(from: postedDate))\n"
                          }
                      postString += "Price: \(post.price)\n"
                   if let description = post.description_ {
                           postString += "Description: \(description)\n\n"
                       } else {
                           postString += "Description: N/A\n\n"
                       }
                  }
               if postString.isEmpty {
                           textView.text = "No product posts found for product type ID \(id)"
                       } else {
                           textView.text = postString
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
    
    func displayRatingsDetails(rating: Double, textView: UITextView){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
            let ratingTolerance = 0.01 // the range of tolerance around the target rating
            fetchRequest.predicate = NSPredicate(format: "product_rating >= %f AND product_rating <= %f", rating - ratingTolerance, rating + ratingTolerance)
            do {
                let results = try context.fetch(fetchRequest)
                let matchingIds = results.map { $0.id }
                let postFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
                postFetchRequest.predicate = NSPredicate(format: "product_id IN %@", matchingIds)
                let postResults = try context.fetch(postFetchRequest)
                if postResults.isEmpty {
                    textView.text = "No product posts found for products with rating \(rating)"
                } else {
                    let postString = postResults.map { "ID: \($0.id)\nproduct_id: \($0.product_id)\ncompany_id: \($0.company_id)\nProduct Type ID: \($0.product_type_id)\nPosted Date: \($0.posted_date ?? Date())\nDescription: \($0.description_ ?? "")\n\n" }.joined()
                    textView.text = postString
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
