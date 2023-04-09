//
//  OrdersTableViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//

import UIKit
import CoreData

class OrdersTableViewController:
    UITableViewController,OrdersViewControllerDelegate {
    
    weak var delegate: OrdersViewControllerDelegate?
    
    var Orders: [OrdersData] = [] // Define productPosts as an array of Companies objects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch companies from CoreData
        fetchOrders()
        // Register the cell class with the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        // Reload table view to display fetched data
        tableView.reloadData()
        // Configure search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Products"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func fetchOrders(with searchText: String? = nil) {
        // Fetch request for Company entity
        let fetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
        
        // Add a predicate to filter the results based on the search text
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "order_id CONTAINS[cd] %@", searchText)
        }
        
        do {
            // Fetch companies from CoreData
            Orders = try context.fetch(fetchRequest)
            
            // Reload table view to display fetched data
            tableView.reloadData()
        } catch {
            print("Error fetching product Posts: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Orders.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let order = Orders[indexPath.row]
        
        // Set the Order ID as the cell's text label
        cell.textLabel?.text = String(order.order_id)
        
        // Set the Order ID as the cell's detail text label
        cell.detailTextLabel?.text = String(order.order_id)
        
        // Add a details disclosure button
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected order from the companies array
        let selectedOrders = Orders[indexPath.row]
        
        // Perform segue to OrdersDetailsViewController with the selected company
        performSegue(withIdentifier: "showOrdersDetails", sender: selectedOrders)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedOrders = Orders[indexPath.row]
        
        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showOrdersDetails", sender: selectedOrders)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrdersDetails" {
            if let orderDetailsVC = segue.destination as? OrderDetailsViewController {
                if let selectedOrder = sender as? OrdersData {
                    // Pass the selectedCompany object to ordersDetailsViewController
                    orderDetailsVC.Order = selectedOrder
                }
            }
        } else if segue.identifier == "addorder" {
            if let addOrderVC = segue.destination as? OrderViewController {
                addOrderVC.delegate = self
            }
        }else if segue.identifier == "updateorder" {
            if let updateOrderVC = segue.destination as? OrderViewController {
                updateOrderVC.delegate = self
            }
        }
    }
    
    func didAddOrder(Order: OrdersData) {
        // Append the newly added company to the companies array
        Orders.append(Order)
        
        // Reload the table view to display the new data
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the selected post from the companies array
            let selectedOrder = Orders[indexPath.row]
            // Delete the selected post from Core Data
            context.delete(selectedOrder)
            do {
                try context.save()
                // Remove the selected company from the posts array
                Orders.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting order: \(error.localizedDescription)")
            }
        }
    }
}
extension OrdersTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Get the search text from the search bar
        if let searchText = searchController.searchBar.text {
            // Call a method to fetch companies with the search text
            fetchOrders(with: searchText)
        }
    }
    
}
