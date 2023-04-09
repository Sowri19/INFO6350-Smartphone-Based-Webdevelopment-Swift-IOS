//
//  ProductTypeTableViewController.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/7/23.
//

import UIKit
import CoreData

class ProductTypeTableViewController: UITableViewController, ProductTypeViewControllerDelegate {
    weak var delegate: ProductTypeViewControllerDelegate?
    var productTypes: [Producttype] = [] // Define productTypes as an array of Producttype objects

    var searchController = UISearchController(searchResultsController: nil)

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch product types from CoreData
                fetchProductTypes()
        // Register the cell class with the table view
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        // Reload table view to display fetched data
        tableView.reloadData()
        // Configure search controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Product Types"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    func fetchProductTypes(with searchText: String? = nil) {
        // Fetch request for ProductType entity
        let fetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
        
        // Add a predicate to filter the results based on the search text
        if let searchText = searchText, !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "product_type CONTAINS[cd] %@", searchText)
        }
        
        do {
            // Fetch product types from CoreData
            productTypes = try context.fetch(fetchRequest)

            // Reload table view to display fetched data
            tableView.reloadData()
        } catch {
            print("Error fetching product types: \(error.localizedDescription)")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let productType = productTypes[indexPath.row]
        
        // Set the product type name as the cell's text label
        cell.textLabel?.text = productType.product_type
        
        // Set the product type ID as the cell's detail text label
        cell.detailTextLabel?.text = String(productType.id)
        
        // Convert the binary data of the logo attribute to a UIImage object
        if let logoData = productType.logo {
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
        // Get the selected product type from the productTypes array
        let selectedProductType = productTypes[indexPath.row]

        // Perform segue to ProductDetailsViewController with the selected product type
        performSegue(withIdentifier: "showProductDetails", sender: selectedProductType)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        // Get the selected product type from the productTypes array
        let selectedProductType = productTypes[indexPath.row]

        // Perform segue to ProductDetailsViewController with the selected product type
        performSegue(withIdentifier: "showProductDetails", sender: selectedProductType)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetails" {
            if let productDetailsVC = segue.destination as? TypeDetailsViewController {
                if let selectedProductType = sender as? Producttype {
                    // Pass the selectedProductType object to TypeDetailsViewController
                    productDetailsVC.productType = selectedProductType
                }
            }
        } else if segue.identifier == "addproducttype" {
            if let addProductTypeVC = segue.destination as? ProductTypeViewController {
                addProductTypeVC.delegate = self
            }
        }else if segue.identifier == "updateproducttype" {
            if let updateProductTypeVC = segue.destination as? ProductTypeViewController {
                updateProductTypeVC.delegate = self
        }
      }
    }

    func didAddProductType(productType: Producttype) {
        // Append the newly added product type to the productTypes array
        productTypes.append(productType)
        
        // Reload the table view to display the new data
        tableView.reloadData()
    }
    func didUpdateProductType(productType: Producttype) {
        // Update the product type in your data source
        
        // Reload the table view to display the updated data
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the selected product type from the productTypes array
            let selectedProductType = productTypes[indexPath.row]

            // checking with the orders
            let orderprodtypefetchRequest: NSFetchRequest<Producttype> = Producttype.fetchRequest()
            orderprodtypefetchRequest.predicate = NSPredicate(format: "id == %ld", selectedProductType.id)
            do {
                let result = try context.fetch(orderprodtypefetchRequest)
                guard let productType = result.first else {
                    // Handle case where no product type found with the given id
                    let alert = UIAlertController(title: "Error", message: "Product Type ID does not exist.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
                if let productTypeParameter = productType.product_type {
                    // Check if any orders are associated with this product type
                    let orderFetchRequest: NSFetchRequest<OrdersData> = OrdersData.fetchRequest()
                    orderFetchRequest.predicate = NSPredicate(format: "product_type == %@", productTypeParameter)
                    
                    do {
                        let orders = try context.fetch(orderFetchRequest)
                        if !orders.isEmpty {
                            let alert = UIAlertController(title: "Error", message: "There are orders associated with this product type. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            present(alert, animated: true, completion: nil)
                            return
                        }
                    }
                    catch let error {
                        // Handle any errors that occur during fetch
                        let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with product type with error: \(error.localizedDescription)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        present(alert, animated: true, completion: nil)
                        return
                    }
                }
            } catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product type with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
            
            // Check if any product posts are associated with this product type
            let productPostFetchRequest: NSFetchRequest<ProductPostData> = ProductPostData.fetchRequest()
            productPostFetchRequest.predicate = NSPredicate(format: "product_type_id == %ld", selectedProductType.id)
            do {
                let productPosts = try context.fetch(productPostFetchRequest)
                if !productPosts.isEmpty {
                    let alert = UIAlertController(title: "Error", message: "There are product posts associated with this product type. Please disassociate or delete them before deleting the product type.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                    return
                }
            } catch let error {
                // Handle any errors that occur during fetch
                let alert = UIAlertController(title: "Error", message: "Failed to fetch product posts associated with product type with error: \(error.localizedDescription)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                return
            }

            // Delete the selected product type from Core Data
            context.delete(selectedProductType)
            do {
                try context.save()
                // Remove the selected product type from the productTypes array
                productTypes.remove(at: indexPath.row)
                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error deleting product type: \(error.localizedDescription)")
            }
        }
    }


}
extension ProductTypeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // Get the search text from the search bar
        if let searchText = searchController.searchBar.text {
            // Call a method to fetch product types with the search text
            fetchProductTypes(with: searchText)
        }
    }
}
