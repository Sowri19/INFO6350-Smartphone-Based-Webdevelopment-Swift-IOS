//
//  ProductPostTableViewController.swift
//  UsingStoryBoard
//

import UIKit
import CoreData

class ProductPostTableViewController: UITableViewController, ProductPostViewControllerDelegate {
    
    weak var delegate: CompanyViewControllerDelegate?
    var ProductPosts: [ProductPostData] = [] // Define productPosts as an array of Companies objects
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch companies from CoreData
        fetchCompanies()
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
    func fetchCompanies(with searchText: String? = nil) {
        // Fetch request for Company entity
        let fetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
        
        // Add a predicate to filter the results based on the search text
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "id CONTAINS[cd] %@", searchText)
        }
        
        do {
            // Fetch companies from CoreData
            ProductPosts = try context.fetch(fetchRequest)
            
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
        return ProductPosts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let productPost = ProductPosts[indexPath.row]
        
        // Set the Product Post ID as the cell's text label
        cell.textLabel?.text = String(productPost.id)
        
        // Set the Product Post ID as the cell's detail text label
        cell.detailTextLabel?.text = String(productPost.id)
        
        // Add a details disclosure button
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedProductPosts = ProductPosts[indexPath.row]
        
        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showProductPostDetails", sender: selectedProductPosts)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedProductPosts = ProductPosts[indexPath.row]
        
        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showProductPostDetails", sender: selectedProductPosts)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductPostDetails" {
            if let productPostDetailsVC = segue.destination as? ProductPostDetailsViewController {
                if let selectedProductPost = sender as? ProductPostData {
                    // Pass the selectedCompany object to CompanyDetailsViewController
                    productPostDetailsVC.ProductPost = selectedProductPost
                }
            }
        } else if segue.identifier == "addproductpost" {
            if let addProductVC = segue.destination as? ProductPostViewController {
                addProductVC.delegate = self
            }
        }else if segue.identifier == "updateproductpost" {
            if let updateProductVC = segue.destination as? ProductPostViewController {
                updateProductVC.delegate = self
            }
        }
    }
    
    func didAddProductPost(ProductPost: ProductPostData) {
        // Append the newly added company to the companies array
        ProductPosts.append(ProductPost)
        
        // Reload the table view to display the new data
        tableView.reloadData()
    }
    func didUpdateProductPost(ProductPost: ProductPostData) {
        // Update the product type in your data source
        // Reload the table view to display the updated data
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the selected post from the companies array
            let selectedProductPost = ProductPosts[indexPath.row]
            let productPostId = selectedProductPost.id // Assuming 'id' is the property
            // Check if any orders are associated with this product type
            let orderFetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
            orderFetchRequest.predicate = NSPredicate(format: "post_id == %ld", productPostId)
            
            do {
                let orders = try context.fetch(orderFetchRequest)
                if !orders.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are orders associated with this product post id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            }
            catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with product post id with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }
         
            // Delete the selected post from Core Data
            context.delete(selectedProductPost)
            do {
                try context.save()
                // Remove the selected company from the posts array
                ProductPosts.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting product post: \(error.localizedDescription)")
            }
        }
    }
}
extension ProductPostTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Get the search text from the search bar
        if let searchText = searchController.searchBar.text {
            // Call a method to fetch companies with the search text
            fetchCompanies(with: searchText)
        }
    }
    
}
