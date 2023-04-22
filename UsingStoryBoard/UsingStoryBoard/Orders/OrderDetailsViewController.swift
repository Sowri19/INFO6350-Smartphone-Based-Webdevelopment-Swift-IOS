//
//  OrderDetailsViewController.swift
//  UsingStoryBoard
//

import UIKit

class OrderDetailsViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var logoImageView: UIImageView!
    
    // Property to store the passed company
    var Order: OrdersData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Update the text of the UITextView
        if let Order = Order {
            let text = "Order ID: \(Order.order_id)\nProduct ID: \(Order.product_id)\nPost ID: \(Order.post_id)\nProduct Type: \(Order.product_type ?? "")\nDate: \(Order.date ?? Date()))"
            textView.text = text
        }
    }

}
