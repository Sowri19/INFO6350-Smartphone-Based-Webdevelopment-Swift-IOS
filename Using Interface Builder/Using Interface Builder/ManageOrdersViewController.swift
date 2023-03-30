//
//  ManageOrdersViewController.swift
//  Using Interface Builder
//
//  Created by Sowri on 3/27/23.
//

import UIKit

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
            if let orderIdText = OrderidField?.text,
                let orderId = Int(orderIdText),
                let postIdText = PostidField?.text,
                let postId = Int(postIdText),
                let productIdText = ProductidField?.text,
                let productId = Int(productIdText),
                let productTypeText = ProductTypeField?.text,
                !productTypeText.isEmpty,
               let productDateText = DateField?.text, !productDateText.isEmpty {

                let type = productManager.productTypes.contains(where: { $0.product_type == productTypeText })
                if !type{
                    let alert = UIAlertController(title: "Error", message: "Invalid product type", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                let post = productManager.productPosts.contains(where: { $0.product_post_id == postId })
                if !post{
                    let alert = UIAlertController(title: "Error", message: "Product post not found!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
                
                let productTypeId = productManager.productTypes.first(where: { $0.product_type == productTypeText })?.id
                let orderTypeID = productManager.productPosts.contains(where: { $0.product_type_id == productTypeId })
                if !orderTypeID{
                    let alert = UIAlertController(title: "Error", message: "Product type and product type ID in post not matching", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
                let ProductID = productManager.productPosts.contains(where: { $0.product_id == productId })
                if !ProductID{
                    let alert = UIAlertController(title: "Error", message: "Product ID and product ID in post not matching", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
                dateFormatter.dateFormat = "yyyy-MM-dd" // Replace with your desired date format
                if let date = dateFormatter.date(from: productDateText) {
                    // Use the date here
                    let order = Order(order_id: orderId, post_id: postId, date: date, product_id: productId, product_type: productTypeText )
                    productManager.orders.append(order)
                    print("Order created successfully!")
                    let alert = UIAlertController(title: "Success", message: "Order Created Successfully", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid Date Format \(String(describing: productDateText))", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid input values!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
    }
    @IBAction func deleteOrder(_ sender: UIButton) {
        print("Delete Order button pressed")
           
           if let orderIdText = OrderidField?.text, let orderId = Int(orderIdText) {
               let orderIndex = productManager.orders.firstIndex(where: { $0.order_id == orderId })
               if let index = orderIndex {
                   // Delete the order from the orders array
                   productManager.orders.remove(at: index)
                   print("Order deleted successfully!")
                   
                   // Show success alert
                   let alert = UIAlertController(title: "Success", message: "Order deleted successfully", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               } else {
                   // Handle case where order id is not valid
                   let alert = UIAlertController(title: "Error", message: "Order ID does not exist to delete.", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   present(alert, animated: true, completion: nil)
               }
           } else {
               // Handle case where order id is not provided
               let alert = UIAlertController(title: "Error", message: "Please enter an ID", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(okAction)
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
