//
//  ProductTableViewController.swift
//  UsingStoryBoard
//

import UIKit
import CoreData

class ProductTableViewController: UITableViewController, ProductViewControllerDelegate {

    weak var delegate: CompanyViewControllerDelegate?
    var Products: [ProductData] = [] // Define productTypes as an array of Companies objects
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
        let fetchRequest: NSFetchRequest<ProductData> = ProductData.fetchRequest()
        
        // Add a predicate to filter the results based on the search text
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        }
        
        do {
            // Fetch companies from CoreData
            Products = try context.fetch(fetchRequest)
            
            // Reload table view to display fetched data
            tableView.reloadData()
        } catch {
            print("Error fetching products: \(error.localizedDescription)")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let product = Products[indexPath.row]
        
        // Set the company name as the cell's text label
        cell.textLabel?.text = product.name
        
        // Set the company ID as the cell's detail text label
        cell.detailTextLabel?.text = String(product.id)
        
        // Convert the binary data of the logo attribute to a UIImage object
        if let logoData = product.logo {
            if let logoImage = UIImage(data: logoData) {
                // Set the logo image as the cell's image view
                cell.imageView?.image = logoImage
            }
        } else {
            // Handle case where logo data is nil, e.g., display a placeholder image or hide the image view
            cell.imageView?.image = nil
        }
        // Configure the appearance of the logo in the cell's image view
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.clipsToBounds = true
        
        // Add a details disclosure button
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedProduct = Products[indexPath.row]

        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showproductDetails", sender: selectedProduct)
    }

    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Get the selected company from the companies array
        let selectedProduct = Products[indexPath.row]

        // Perform segue to CompanyDetailsViewController with the selected company
        performSegue(withIdentifier: "showproductDetails", sender: selectedProduct)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showproductDetails" {
            if let productDetailsVC = segue.destination as? ProductDetailsViewController {
                if let selectedProduct = sender as? ProductData {
                    // Pass the selectedCompany object to CompanyDetailsViewController
                    productDetailsVC.Product = selectedProduct
                }
            }
        } else if segue.identifier == "addproduct" {
            if let addProductVC = segue.destination as? ProductViewController {
                addProductVC.delegate = self
            }
        }else if segue.identifier == "updateproduct" {
            if let updateProductVC = segue.destination as? ProductViewController {
                updateProductVC.delegate = self
            }
        }
    }

    func didAddProduct(Product: ProductData) {
        // Append the newly added company to the companies array
        Products.append(Product)

        // Reload the table view to display the new data
        tableView.reloadData()
    }
    func didUpdateProduct(Product: ProductData) {
        // Update the product type in your data source
        // Reload the table view to display the updated data
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the selected company from the companies array
            let selectedProduct = Products[indexPath.row]
            
            let productId = selectedProduct.id // Assuming 'id' is the property

            // Check if any orders are associated with this product type
            let orderFetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
            orderFetchRequest.predicate = NSPredicate(format: "product_id == %ld", productId)

            do {
                let orders = try context.fetch(orderFetchRequest)
                if !orders.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are orders associated with this product id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            }
            catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with product id with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Check if any product posts are associated with this company
            let productPostFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            productPostFetchRequest.predicate = NSPredicate(format: "product_id == %ld", productId)
            do {
                let productPosts = try context.fetch(productPostFetchRequest)
                if !productPosts.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are product posts associated with this product id. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with product with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Delete the selected company from Core Data
            context.delete(selectedProduct)
            do {
                try context.save()
                // Remove the selected company from the companies array
                Products.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting product: \(error.localizedDescription)")
            }
        }
    }
}
extension ProductTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Get the search text from the search bar
        if let searchText = searchController.searchBar.text {
            // Call a method to fetch companies with the search text
            fetchCompanies(with: searchText)
        }
    }
}
