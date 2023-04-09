//
//  ManageOrdersViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit
import CoreData

class ManageOrdersViewController: UIViewController {
    @IBOutlet weak var OrderidField: UITextField!
    @IBOutlet weak var PostidField: UITextField!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var ProductidField: UITextField!
    @IBOutlet weak var ProductTypeField: UITextField!
    let dateFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createOrderButtonTapped(_ sender: UIButton) {
            let vc = ManageOrdersViewController(nibName: "CreateOrderView", bundle: nil)
            self.present(vc, animated: true, completion: nil)
        }

    @IBAction func deleteOrderButtonTapped(_ sender: UIButton) {
        let vc = ManageOrdersViewController(nibName: "DeleteOrderView", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createOrder(_ sender: UIButton) {
        print("Create Order button pressed")
        guard let orderIdText = OrderidField?.text, let orderId = Int(orderIdText),
              let postIdText = PostidField?.text, let postId = Int(postIdText),
              let productIdText = ProductidField?.text, let productId = Int(productIdText),
              let productTypeText = ProductTypeField?.text, !productTypeText.isEmpty,
              let productDateText = DateField?.text, !productDateText.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
        guard let date = dateFormatter.date(from: productDateText) else {
            let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        // Check if product Post already exists
        let postFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
        postFetchRequest.predicate = NSPredicate(format: "id == %ld", postId)
        do {
            let productPosts = try context.fetch(postFetchRequest)
            if productPosts.count == 0 {
                let alert = UIAlertController(title: "Error", message: "Product Post with the following does not exists:\nID: \(postId)", preferredStyle: .alert)
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
        // Check if product type exists
        let producttypeRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
        producttypeRequest.predicate = NSPredicate(format: "product_type == %@", productTypeText)
        do {
            let result = try context.fetch(producttypeRequest)
            if let productType = result.first {
                let productTypeId = productType.id
                // continue with the rest of the code
                // Check if product Post product type id already exists with product type id in product type data base
                let postFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
                postFetchRequest.predicate = NSPredicate(format: "product_type_id == %ld", productTypeId)
                do {
                    let productPosts = try context.fetch(postFetchRequest)
                    if productPosts.count == 0 {
                        let alert = UIAlertController(title: "Error", message: "Product type with the following does not exists in the product post database:\nID: \(postId)", preferredStyle: .alert)
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
            } else {
                let alert = UIAlertController(title: "Error", message: "Product type not found.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
        } catch {
            let alert = UIAlertController(title: "Error", message: "Failed to fetch product type.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        
        let orderFetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
        orderFetchRequest.predicate = NSPredicate(format: "order_id == %ld", orderId)

        do {
            let existingOrder = try context.fetch(orderFetchRequest)
            if existingOrder.count > 0 {
                // An order with the given orderId already exists, show an error message
                let alert = UIAlertController(title: "Error", message: "An order with the given ID already exists.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
            // Create new order data object and set its properties
            let newOrderData = OrdersData(context: context)
            newOrderData.order_id = Int64(orderId)
            newOrderData.post_id = Int64(postId)
            newOrderData.date = date
            newOrderData.product_id = Int64(productId)
            newOrderData.product_type = productTypeText

            // Save changes
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Order added successfully", preferredStyle: .alert)
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
    @IBAction func deleteOrder(_ sender: UIButton) {
        print("Delete Order button pressed")
            if let orderIdText = OrderidField?.text, let orderDeleteId = Int(orderIdText) {
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let fetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "order_id == %d", orderDeleteId)
                do {
                    let results = try context.fetch(fetchRequest)
                    if let orderToDelete = results.first {
                        context.delete(orderToDelete)
                        try context.save()
                        // Deletion was successful
                        let alert = UIAlertController(title: "Order Deleted Successfully", message: "Press ok to continue", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    } else {
                        // Deletion failed
                        let alert = UIAlertController(title: "Error", message: "Order ID does not exist to delete.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                    }
                } catch {
                    // handle error
                    print("Error deleting order: \(error)")
                    let alert = UIAlertController(title: "Error", message: "Unable to delete order.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // handle case where idField has no text or the text is not a valid integer
                let alert = UIAlertController(title: "Error", message: "Please enter a valid Order ID", preferredStyle: .alert)
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
