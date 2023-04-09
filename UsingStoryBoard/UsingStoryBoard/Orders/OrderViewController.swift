//
//  OrderViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//

import UIKit
import CoreData

protocol OrdersViewControllerDelegate: AnyObject {
    func didAddOrder(Order: OrdersData)
}
class OrderViewController: UIViewController {
    @IBOutlet weak var OrderidField: UITextField!
    @IBOutlet weak var PostidField: UITextField!
    @IBOutlet weak var DateField: UITextField!
    @IBOutlet weak var ProductidField: UITextField!
    @IBOutlet weak var ProductTypeField: UITextField!
    let dateFormatter = DateFormatter()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: OrdersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createOrder(_ sender: UIButton) {
        print("Create Order button pressed")
        guard let orderIdText = OrderidField?.text, let orderId = Int(orderIdText),
              let postIdText = PostidField?.text, let postId = Int(postIdText),
              let productIdText = ProductidField?.text, let productId = Int(productIdText),
              let productTypeText = ProductTypeField?.text, !productTypeText.isEmpty
//              let productDateText = DateField?.text, !productDateText.isEmpty
        else {
            let alert = UIAlertController(title: "Error", message: "Please fill all required fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let selectedDate = datePicker.date
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
            newOrderData.date = selectedDate
            newOrderData.product_id = Int64(productId)
            newOrderData.product_type = productTypeText

            // Save changes
            try context.save()
            let alert = UIAlertController(title: "Success", message: "Order added successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            // Call the delegate method with the newly created order
            delegate?.didAddOrder(Order: newOrderData)
        } catch {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
